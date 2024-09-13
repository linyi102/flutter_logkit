import 'package:flutter_logkit/logger.dart';
import 'package:flutter_logkit/models/print_log_settings.dart';

final logger = LogkitLogger(
  printLogSettings: const PrintLogSettings(
    printLog: true,
    printTopic: true,
    printTime: true,
  ),
);
