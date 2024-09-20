import 'package:flutter_logkit/src/models/models.dart';
import 'package:intl/intl.dart';

abstract class LogRecord {
  final String type;
  final String tag;
  final String message;
  final DateTime time;
  final LogLevel level;
  final Object? error;
  final StackTrace? stackTrace;
  final LogSettings settings;

  LogRecord({
    required this.type,
    required this.tag,
    required this.message,
    required this.level,
    this.error,
    this.stackTrace,
    this.settings = const LogSettings(),
  }) : time = DateTime.now();

  String get formatedTime {
    return DateFormat('yy-MM-dd HH:mm:ss').format(time);
  }

  String get consoleMessage => _fullMessage(settings);

  String get fullMessage => _fullMessage(const LogSettings());

  String _fullMessage(LogSettings logSettings) {
    final texts = [
      if (logSettings.printTime) '[$formatedTime]',
      if (type.isNotEmpty) '[$type]',
      if (tag.isNotEmpty) '[$tag]',
      if (message.isNotEmpty) message,
    ];
    final lines = [
      texts.join(' '),
      if (error != null) '$error',
      if (stackTrace != null) '$stackTrace',
    ];
    return lines.join('\n');
  }
}
