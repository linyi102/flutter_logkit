import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:example/http/dio_log_interceptor.dart';
import 'package:example/log.dart';
import 'package:flutter/foundation.dart';
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
            title: const Text('Compute Exception'),
            onTap: () {
              compute(_errorSquare, 3);
            },
          ),
          ListTile(
            title: const Text('Isolate.run Exception'),
            onTap: () {
              Isolate.run(() => _errorSquare(3));
            },
          ),
          ListTile(
            title: const Text('Isolate.spawn Exception'),
            onTap: () async {
              int number = 3;
              final receivePort = ReceivePort();
              receivePort.listen((message) {
                logger.info('isolate square($number)=$message');
                receivePort.close();
              });

              final newIsolate = await Isolate.spawn(
                (message) {
                  final sendPort = message[0] as SendPort;
                  final value = message[1] as num;
                  throw Exception('isolate square error');
                  // ignore: dead_code
                  sendPort.send(value * value);
                },
                [receivePort.sendPort, number],
                // 方法1：主isolate会收到[err, stack]数组消息
                // onError: receivePort.sendPort,
              );
              // 方法2
              // 注：Isolate.current.addErrorListener并不会监听到
              newIsolate.addErrorListener(RawReceivePort((dynamic pair) async {
                final isolateError = pair as List<dynamic>;
                logger.error('catch isolate error: $isolateError');
              }).sendPort);
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

num _errorSquare(num value) {
  throw Exception('compute square error');
  // ignore: dead_code
  return value * value;
}
