import 'package:dio/dio.dart';
import 'package:example/http/dio_log_interceptor.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tap without print time'),
            onTap: () {
              logger.info('tap',
                  tag: logTag, settings: const LogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('Long message'),
            onTap: () {
              logger.info('long' * 99,
                  tag: logTag, settings: const LogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('For log'),
            onTap: () async {
              for (int i = 0; i < 5; i++) {
                await Future.delayed(const Duration(seconds: 1));
                logger.info('for $i', tag: logTag);
              }
            },
          ),
          ListTile(
            title: const Text('Manual Catch Exception'),
            onTap: () {
              try {
                throw ArgumentError.notNull('name1');
              } catch (e, stack) {
                logger.error('manual catch error', error: e, stackTrace: stack);
              }
            },
          ),
          ListTile(
            title: const Text('Unhandled Exception (Sync)'),
            onTap: () {
              throw Exception('sync method');
            },
          ),
          ListTile(
            title: const Text('Unhandled Exception (Async)'),
            onTap: () async {
              throw Exception('async method');
            },
          ),
          ListTile(
            title: const Text('Http baidu'),
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
            title: const Text('Http error'),
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
