import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/src/utils/pretty.dart';

class RouteLogRecord extends LogRecord {
  RouteLogRecord({
    required super.tag,
    required super.message,
  }) : super(type: LogRecordType.route.key, level: LogLevel.info);

  factory RouteLogRecord.fromRoute(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? oldRoute, {
    String tag = '',
  }) {
    String msg = action;
    if (route != null) msg += ' ${route.settings.name ?? '<unknown>'}';
    if (oldRoute != null) {
      msg += ' from ${oldRoute.settings.name ?? '<unknown>'}';
    }
    if (route?.settings.arguments != null) {
      msg += 'Arguments'.mdH3;
      msg += route?.settings.arguments?.toString() ?? '';
    }
    return RouteLogRecord(message: msg, tag: tag);
  }
}
