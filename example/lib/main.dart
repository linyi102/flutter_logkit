import 'package:example/home.dart';
import 'package:example/log.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter/material.dart';

void main() {
  logger.setupErrorCollector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logkit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      navigatorObservers: [RouterLogObserver(logger)],
      home: LogkitOverlayAttacher(
        logger: logger,
        child: const MyHomePage(title: 'Logkit Demo'),
      ),
    );
  }
}
