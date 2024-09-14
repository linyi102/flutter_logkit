import 'package:logger/logger.dart';

abstract class LogRecord {
  final String type;
  final String title;
  final String message;
  final DateTime time;
  final Level level;
  final Object? error;
  final StackTrace? stackTrace;

  LogRecord({
    required this.type,
    required this.title,
    required this.message,
    required this.level,
    this.error,
    this.stackTrace,
  }) : time = DateTime.now();

  String get formatedTime => time.toString();

  String generatePrint();
}
