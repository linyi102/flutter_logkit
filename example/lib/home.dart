import 'package:dio/dio.dart';
import 'package:example/http/dio_interceptor.dart';
import 'package:example/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logTag = 'Home';
  final dio = Dio()..interceptors.add(DioLogInterceptor(logger));

  @override
  void initState() {
    super.initState();
    logger.i('attach logkit overlay');
    logger.attachOverlay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: [
          ListTile(
            title: const Text('tap without print time'),
            onTap: () {
              logger.i('tap',
                  tag: logTag, settings: const LogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('long message'),
            onTap: () {
              logger.i('long' * 99,
                  tag: logTag, settings: const LogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('for log'),
            onTap: () async {
              for (int i = 0; i < 5; i++) {
                await Future.delayed(const Duration(seconds: 1));
                logger.i('for $i', tag: logTag);
              }
            },
          ),
          ListTile(
            title: const Text('Catch Exception'),
            onTap: () {
              try {
                throw ArgumentError.notNull('name1');
              } catch (e, stack) {
                logger.e('manual catch error', error: e, stackTrace: stack);
              }
            },
          ),
          ListTile(
            title: const Text('Unhandled Exception'),
            onTap: () {
              throw ArgumentError.notNull('name2');
            },
          ),
          ListTile(
            title: const Text('http baidu'),
            onTap: () async {
              final options = RequestOptions(
                  path: 'https://www.baidu.com',
                  method: 'get',
                  headers: {
                    'platform': 'mac',
                  });
              await dio.fetch(options);
            },
          ),
          ListTile(
            title: const Text('http error'),
            onTap: () async {
              await dio.post('https://www.none.com', data: {
                'prop': 'value',
              });
            },
          ),
        ],
      ),
    );
  }
}
