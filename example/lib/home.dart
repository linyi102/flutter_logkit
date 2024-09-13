import 'dart:io';

import 'package:example/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/simple_log_settings.dart';
import 'package:flutter_logkit/models/network_log_record.dart';

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
              final httpClient = HttpClient();
              final request =
                  await httpClient.getUrl(Uri.parse('https://www.baidu.com'));
              request.headers.add(
                "user-agent",
                "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
              );
              logger.logTyped(NetworkRequestLogRecord.fromHttpRequest(request));

              final response = await request.close();
              logger.logTyped(
                  NetworkResponseLogRecord.fromHttpResponse(response));
            },
          ),
        ],
      ),
    );
  }
}
