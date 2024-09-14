import 'package:flutter_logkit/logger.dart';
import 'package:flutter_logkit/models/log_settings.dart';

final logger = LogkitLogger(
  logSettings: const LogSettings(
    printLog: true,
    printTime: true,
  ),
);
