import 'package:dio/dio.dart';
import 'package:example/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_settings.dart';
import 'package:flutter_logkit/models/http_log_record.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logTag = 'Home';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logger.i('attach logkit overlay');
      logger.attachOverlay(context);
    });
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
            title: const Text('network'),
            onTap: () async {
              final dio = Dio();
              final options = RequestOptions(
                  path: 'https://www.baidu.com',
                  method: 'get',
                  headers: {
                    'platform': 'mac',
                  });
              const logTag = 'DioFakeInterceptor';
              logger.logTyped(HttpRequestLogRecord.generate(
                tag: logTag,
                method: options.method,
                url: options.uri.toString(),
                headers: options.headers,
                body: options.data,
              ));
              final resp = await dio.fetch(options);
              logger.logTyped(HttpResponseLogRecord.generate(
                tag: logTag,
                method: resp.requestOptions.method,
                url: resp.requestOptions.uri.toString(),
                statusCode: resp.statusCode,
                statusMessage: resp.statusMessage,
                headers: resp.headers,
                body: resp.data,
              ));
            },
          ),
        ],
      ),
    );
  }
}
