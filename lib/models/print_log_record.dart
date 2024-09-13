import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';

class PrintLogRecord extends LogRecord {
  String message;

  PrintLogRecord(this.message, {required super.level})
      : super(type: LogRecordType.print);
}
