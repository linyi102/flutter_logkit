import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_type.dart';
import 'package:flutter_logkit/utils/pretty.dart';
import 'package:logger/logger.dart';

class HttpRequestLogRecord extends LogRecord {
  HttpRequestLogRecord._({
    required super.message,
    required super.tag,
  }) : super(type: LogRecordType.httpRequest.key, level: Level.info);

  factory HttpRequestLogRecord.generate({
    String tag = '',
    required String method,
    required String url,
    Object? headers,
    Object? body,
  }) {
    String msg = '[${method.toUpperCase()}] $url';
    if (body != null) {
      msg += 'Body'.mdH3;
      msg += body.prettyJson.mdCodeblock;
    }
    if (headers != null) {
      msg += 'Headers'.mdH3;
      msg += headers.prettyJson.mdCodeblock;
    }

    return HttpRequestLogRecord._(
      message: msg,
      tag: tag,
    );
  }

  @override
  String generatePrint() {
    return message;
  }
}

class HttpResponseLogRecord extends LogRecord {
  HttpResponseLogRecord._({
    required super.message,
    required super.tag,
  }) : super(type: LogRecordType.httpResponse.key, level: Level.info);

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
    if (body != null) {
      msg += 'Body'.mdH3;
      msg += body.prettyJson.mdCodeblock;
    }
    if (headers != null) {
      msg += 'Headers'.mdH3;
      msg += headers.prettyJson.mdCodeblock;
    }

    return HttpResponseLogRecord._(
      message: msg,
      tag: tag,
    );
  }

  @override
  String generatePrint() {
    return message;
  }
}
