import 'package:flutter_logkit/models/log_level.dart';
import 'package:intl/intl.dart';

abstract class LogRecord {
  final String type;
  final String tag;
  final String message;
  final DateTime time;
  final LogLevel level;
  final Object? error;
  final StackTrace? stackTrace;

  LogRecord({
    required this.type,
    required this.tag,
    required this.message,
    required this.level,
    this.error,
    this.stackTrace,
  }) : time = DateTime.now();

  String get formatedTime {
    return DateFormat('yy-MM-dd HH:mm:ss').format(time);
  }

  String generatePrint() => message;
}
