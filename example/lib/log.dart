import 'package:flutter_logkit/logkit.dart';

final logger = LogkitLogger(
  logkitSettings: const LogkitSettings(
    printToConsole: true,
    printTime: true,
    maxLogCount: 100,
  ),
);
