import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/print_log_record.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  ValueNotifier<List<LogRecord>> get records => _records;

  LogkitLogger() {
    _logger = Logger();
  }

  void v(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    t(message, time: time, error: error, stackTrace: stackTrace);
  }

  void t(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logPrint(Level.trace, message,
        time: time, error: error, stackTrace: stackTrace);
  }

  void d(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logPrint(Level.debug, message,
        time: time, error: error, stackTrace: stackTrace);
  }

  void i(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logPrint(Level.info, message,
        time: time, error: error, stackTrace: stackTrace);
  }

  void w(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logPrint(Level.warning, message,
        time: time, error: error, stackTrace: stackTrace);
  }

  void e(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logPrint(Level.error, message,
        time: time, error: error, stackTrace: stackTrace);
  }

  void logPrint(
    Level level,
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    message ??= '<null>';
    if (message.isEmpty) message = '<empty>';

    _logger.log(level, message,
        time: time, error: error, stackTrace: stackTrace);
    records.value.add(PrintLogRecord(message, level: level));
  }

  // TODO
  void logNetwork() {}

  // TODO
  void logRoute() {}
}
