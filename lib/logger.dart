import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/simple_log_record.dart';
import 'package:flutter_logkit/models/simple_log_settings.dart';
import 'package:flutter_logkit/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  ValueNotifier<List<LogRecord>> get records => _records;
  final SimpleLogSettings simpleLogSettings;

  LogkitLogger({
    this.simpleLogSettings = const SimpleLogSettings(
        printLog: true, printTime: true, printTopic: true),
  }) {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        colors: true,
        printEmojis: true,
        noBoxingByDefault: true,
        dateTimeFormat: DateTimeFormat.none,
      ),
    );
  }

  void attachOverlay(BuildContext context) {
    LogkitOverlay.attach(context: context, logger: this);
  }

  /// Log a message at level [Level.trace].
  void t(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    logPrint(Level.trace, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.debug].
  void d(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    logPrint(Level.debug, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.info].
  void i(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    logPrint(Level.info, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.warning].
  void w(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    logPrint(Level.warning, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.error].
  void e(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    logPrint(Level.error, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void logPrint(
    Level level,
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    SimpleLogSettings? settings,
  }) {
    message ??= '<null>';
    if (message.isEmpty) message = '<empty>';
    settings ??= simpleLogSettings;

    final record = SimpleLogRecord(
      message: message,
      level: level,
      tag: tag ?? '',
      settings: settings,
    );
    logTyped(record);
  }

  void logTyped(LogRecord record) {
    records.value.add(record);
    _logger.log(record.level, record.generatePrint(), time: record.time);
  }
}
