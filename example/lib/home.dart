import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/simple_log_settings.dart';
import 'package:flutter_logkit/models/http_log_record.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logTopic = 'Home';

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
                  tag: logTopic,
                  settings: const SimpleLogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('long message'),
            onTap: () {
              logger.i('long' * 99,
                  tag: logTopic,
                  settings: const SimpleLogSettings(printTime: false));
            },
          ),
          ListTile(
            title: const Text('catch error'),
            onTap: () {
              try {
                throw ArgumentError.notNull('fake');
              } catch (e) {
                logger.e(e.toString(), error: e);
              }
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
              logger.logTyped(HttpRequestLogRecord.generate(
                method: options.method,
                url: options.uri.toString(),
                headers: options.headers,
                body: options.data,
              ));
              final resp = await dio.fetch(options);
              logger.logTyped(HttpResponseLogRecord.generate(
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
