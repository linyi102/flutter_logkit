import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/utils/pretty.dart';

class RouteLogRecord extends LogRecord {
  RouteLogRecord({
    required super.message,
  }) : super(tag: '', type: LogRecordType.route.key, level: LogLevel.info);

  factory RouteLogRecord.fromRoute(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? oldRoute,
  ) {
    String msg = action;
    if (route != null) msg += ' ${route.settings.name ?? '<unknown>'}';
    if (oldRoute != null) {
      msg += ' from ${oldRoute.settings.name ?? '<unknown>'}';
    }
    if (route?.settings.arguments != null) {
      msg += 'Arguments'.mdH3;
      msg += route?.settings.arguments?.toString() ?? '';
    }
    return RouteLogRecord(message: msg);
  }
}
