// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';

class PrintLogRecord extends LogRecord {
  String message;
  String topic;

  PrintLogRecord(
    this.message, {
    required super.level,
    required this.topic,
  }) : super(type: LogRecordType.print);

  @override
  String toString() => 'PrintLogRecord(message: $message, topic: $topic)';

  @override
  String format() {
    return '[$topic] $message';
  }
}
