// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:flutter_logkit/models/print_log_settings.dart';

class PrintLogRecord extends LogRecord {
  final String message;
  final String topic;
  final PrintLogSettings settings;

  PrintLogRecord(
    this.message, {
    required super.level,
    required this.topic,
    required this.settings,
  }) : super(type: LogRecordType.print);

  @override
  String toString() => 'PrintLogRecord(message: $message, topic: $topic)';

  @override
  String format() {
    final texts = [
      if (settings.printTime) '[$formatedTime]',
      if (settings.printTopic) '[$topic]',
      message,
    ];
    return texts.join(' ');
  }
}
