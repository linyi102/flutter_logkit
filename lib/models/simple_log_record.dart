import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:flutter_logkit/models/log_settings.dart';

class SimpleLogRecord extends LogRecord {
  final String tag;
  final LogSettings settings;

  SimpleLogRecord({
    super.title = '',
    required super.message,
    required super.level,
    required this.tag,
    required this.settings,
    super.error,
    super.stackTrace,
  }) : super(type: LogRecordType.$default.key);

  @override
  String generatePrint() {
    final texts = [
      if (settings.printTime) '[$formatedTime]',
      if (tag.isNotEmpty) '[$tag]',
      message,
      if (error != null) '\n$error',
      if (stackTrace != null) '\n$stackTrace',
    ];
    return texts.join(' ');
  }
}
