import 'package:flutter_logkit/src/models/log_record.dart';
import 'package:flutter_logkit/src/models/log_record_type.dart';

class SimpleLogRecord extends LogRecord {
  SimpleLogRecord({
    super.tag = '',
    required super.message,
    required super.level,
    super.error,
    super.stackTrace,
    super.settings,
  }) : super(type: LogRecordType.$default.key);
}
