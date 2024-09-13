import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/print_log_record.dart';
import 'package:flutter_logkit/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  ValueNotifier<List<LogRecord>> get records => _records;
  final bool printLog;

  LogkitLogger({
    this.printLog = false,
  }) {
    _logger = Logger(
      printer: SimplePrinter(printTime: true),
    );
  }

  void attachOverlay(BuildContext context) {
    LogkitOverlay.attach(context);
  }

  void v(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    t(message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void t(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    logPrint(Level.trace, message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void d(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    logPrint(Level.debug, message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void i(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    logPrint(Level.info, message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void w(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    logPrint(Level.warning, message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void e(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    logPrint(Level.error, message,
        time: time,
        error: error,
        stackTrace: stackTrace,
        topic: topic,
        printLog: printLog);
  }

  void logPrint(
    Level level,
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? topic,
    bool? printLog,
  }) {
    message ??= '<null>';
    if (message.isEmpty) message = '<empty>';

    final record =
        PrintLogRecord(message, level: level, topic: topic ?? 'default');
    records.value.add(record);
    if (printLog ?? this.printLog) {
      _logger.log(level, record.format(),
          time: time, error: error, stackTrace: stackTrace);
    }
  }

  // TODO
  void logNetwork() {}

  // TODO
  void logRoute() {}
}
