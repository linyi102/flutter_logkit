import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:logger/logger.dart';

class LogRecord {
  final LogRecordType type;
  final DateTime time;
  final Level level;

  LogRecord({
    required this.type,
    required this.level,
  }) : time = DateTime.now();
}
