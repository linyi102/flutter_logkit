import 'package:flutter_logkit/logger.dart';
import 'package:flutter_logkit/models/simple_log_settings.dart';

final logger = LogkitLogger(
  simpleLogSettings: const SimpleLogSettings(
    printLog: true,
    printTopic: true,
    printTime: true,
  ),
);
