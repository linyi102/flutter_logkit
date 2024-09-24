import 'package:flutter_logkit/logkit.dart';

class UnhandledErrorLogRecord extends LogRecord {
  UnhandledErrorLogRecord({
    required super.tag,
    required super.message,
    super.error,
    super.stackTrace,
    super.settings,
  }) : super(type: LogRecordType.unhandledError.key, level: LogLevel.error);
}
