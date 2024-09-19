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

  String get consoleMessage {
    final texts = [
      if (settings.printTime) '[$formatedTime]',
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

  String get fullMessage => [
        level,
        type,
        tag,
        formatedTime,
        message,
        error,
        stackTrace
      ].where((e) => e != null && e != '').join('\n');
}
