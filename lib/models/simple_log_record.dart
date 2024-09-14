import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:flutter_logkit/models/simple_log_settings.dart';

class SimpleLogRecord extends LogRecord {
  final String tag;
  final SimpleLogSettings settings;

  SimpleLogRecord({
    required super.message,
    required super.level,
    required this.tag,
    required this.settings,
  }) : super(
          type: LogRecordType.$default.key,
          title: '',
        );

  @override
  String toString() => 'SimpleLogRecord(message: $message, tag: $tag)';

  @override
  String generatePrint() {
    final texts = [
      if (settings.printTime) '[$formatedTime]',
      if (settings.printTopic && tag.isNotEmpty) '[$tag]',
      message,
    ];
    return texts.join(' ');
  }
}
