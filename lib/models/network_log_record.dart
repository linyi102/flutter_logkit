import 'dart:io';

import 'package:flutter_logkit/models/log_record.dart';
import 'package:logger/logger.dart';

const _kType = 'network';

class NetworkRequestLogRecord extends LogRecord {
  NetworkRequestLogRecord._({
    required super.title,
    required super.message,
  }) : super(type: _kType, level: Level.info);

  factory NetworkRequestLogRecord.fromHttpRequest(HttpClientRequest request) {
    return NetworkRequestLogRecord._(
      title: '${request.method} ${request.uri}',
      // TODO body
      message: '${request.headers}',
    );
  }

  @override
  String generatePrint() {
    return '$title\n$message';
  }
}

class NetworkResponseLogRecord extends LogRecord {
  NetworkResponseLogRecord._({
    required super.title,
    required super.message,
  }) : super(type: _kType, level: Level.info);

  // TODO url、body
  // 或手动传入更明显的参数 statusCode、header、body
  factory NetworkResponseLogRecord.fromHttpResponse(
      HttpClientResponse response) {
    return NetworkResponseLogRecord._(
      title: '',
      message: '${response.statusCode}\n${response.headers}',
    );
  }

  @override
  String generatePrint() {
    return '$title\n$message';
  }
}
