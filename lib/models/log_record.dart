import 'package:logger/logger.dart';

abstract class LogRecord {
  final String type;
  final String title;
  final String message;
  final DateTime time;
  final Level level;

  LogRecord({
    required this.type,
    required this.title,
    required this.message,
    required this.level,
  }) : time = DateTime.now();

  String get formatedTime => time.toString();

  String generatePrint();
}
