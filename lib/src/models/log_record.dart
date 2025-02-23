import 'package:flutter_logkit/src/models/models.dart';

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
    return '${_padZero(time.year % 100)}-${_padZero(time.month)}-${_padZero(time.day)} ${_padZero(time.hour)}:${_padZero(time.minute)}:${_padZero(time.second)}';
  }

  String _padZero(int number) {
    return number.toString().padLeft(2, '0');
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
