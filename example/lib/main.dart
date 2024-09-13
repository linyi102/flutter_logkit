import 'package:example/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/print_log_settings.dart';

void main() {
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
      home: const MyHomePage(title: 'Logkit Demo'),
    );
  }
}

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
                  topic: logTopic,
                  settings: const PrintLogSettings(printTime: false));
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
        ],
      ),
    );
  }
}
