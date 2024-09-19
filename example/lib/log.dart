import 'package:flutter_logkit/logkit.dart';

final logger = LogkitLogger(
  logSettings: const LogkitSettings(
    printToConsole: true,
    printTime: true,
    maxLogCount: 100,
  ),
);
