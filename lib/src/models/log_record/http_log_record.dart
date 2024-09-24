import 'package:flutter_logkit/src/models/log_level.dart';
import 'package:flutter_logkit/src/models/log_record.dart';
import 'package:flutter_logkit/src/models/log_record_type.dart';
import 'package:flutter_logkit/src/utils/pretty.dart';

class HttpRequestLogRecord extends LogRecord {
  HttpRequestLogRecord._({
    required super.message,
    required super.tag,
  }) : super(type: LogRecordType.httpRequest.key, level: LogLevel.info);

  factory HttpRequestLogRecord.generate({
    String tag = '',
    required String method,
    required String url,
    Object? headers,
    Object? body,
  }) {
    String msg = '[${method.toUpperCase()}] $url';
    if (body != null) msg += '\nBody: ${body.prettyJson}';
    if (headers != null) msg += '\nHeaders: ${headers.prettyJson}';

    return HttpRequestLogRecord._(
      message: msg,
      tag: tag,
    );
  }
}

class HttpResponseLogRecord extends LogRecord {
  HttpResponseLogRecord._({
    required super.message,
    required super.tag,
  }) : super(type: LogRecordType.httpResponse.key, level: LogLevel.info);

  factory HttpResponseLogRecord.generate({
    String tag = '',
    required String method,
    required String url,
    int? statusCode,
    String? statusMessage,
    Object? headers,
    Object? body,
  }) {
    String msg = '[${method.toUpperCase()}] $url';
    if (statusCode != null) msg += '\nStatusCode: $statusCode';
    if (statusMessage != null) msg += '\nStatusMessage: $statusMessage';
    if (body != null) msg += '\nBody: ${body.prettyJson}';
    if (headers != null) msg += '\nHeaders: ${headers.prettyJson}';

    return HttpResponseLogRecord._(
      message: msg,
      tag: tag,
    );
  }
}

class HttpErrorLogRecord extends LogRecord {
  HttpErrorLogRecord._({
    required super.message,
    required super.tag,
    super.error,
  }) : super(type: LogRecordType.httpError.key, level: LogLevel.error);

  factory HttpErrorLogRecord.generate({
    String tag = '',
    required String method,
    required String url,
    int? statusCode,
    String? statusMessage,
    Object? headers,
    Object? body,
    Object? error,
  }) {
    String msg = '[${method.toUpperCase()}] $url';
    if (statusCode != null) msg += '\nStatusCode: $statusCode';
    if (statusMessage != null) msg += '\nStatusMessage: $statusMessage';
    if (body != null) msg += '\nBody: ${body.prettyJson}';
    if (headers != null) msg += '\nHeaders: ${headers.prettyJson}';

    return HttpErrorLogRecord._(
      message: msg,
      tag: tag,
      error: error,
    );
  }
}
