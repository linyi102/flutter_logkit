import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:flutter_logkit/utils/pretty.dart';
import 'package:logger/logger.dart';

class HttpRequestLogRecord extends LogRecord {
  HttpRequestLogRecord._({
    required super.title,
    required super.message,
  }) : super(type: LogRecordType.httpRequest.key, level: Level.info);

  factory HttpRequestLogRecord.generate({
    required String method,
    required String url,
    Object? headers,
    Object? body,
  }) {
    String msg = '[$method] $url';
    if (headers != null) msg += '\nHeaders: ${headers.prettyJson}';
    if (body != null) msg += '\nBody: ${body.prettyJson}';

    return HttpRequestLogRecord._(
      title: 'request',
      message: msg,
    );
  }

  @override
  String generatePrint() {
    return '$title\n$message';
  }
}

class HttpResponseLogRecord extends LogRecord {
  HttpResponseLogRecord._({
    required super.title,
    required super.message,
  }) : super(type: LogRecordType.httpResponse.key, level: Level.info);

  factory HttpResponseLogRecord.generate({
    required String method,
    required String url,
    int? statusCode,
    String? statusMessage,
    Object? headers,
    Object? body,
  }) {
    String msg = '[$method] $url';
    if (statusCode != null) msg += '\nStatusCode: $statusCode';
    if (statusMessage != null) msg += '\nStatusMessage: $statusMessage';
    if (headers != null) msg += '\nHeaders: ${headers.prettyJson}';
    if (body != null) msg += '\nBody: ${body.prettyJson}';

    return HttpResponseLogRecord._(
      title: 'response',
      message: msg,
    );
  }

  @override
  String generatePrint() {
    return '$title\n$message';
  }
}
