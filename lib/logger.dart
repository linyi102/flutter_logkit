import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/simple_log_record.dart';
import 'package:flutter_logkit/models/log_settings.dart';
import 'package:flutter_logkit/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  final _types = ValueNotifier(<String>[]);
  ValueNotifier<List<LogRecord>> get records => _records;
  ValueNotifier<List<String>> get types => _types;
  final LogSettings logSettings;

  LogkitLogger({
    this.logSettings = const LogSettings(printLog: true, printTime: true),
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
    LogSettings? settings,
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
    LogSettings? settings,
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
    LogSettings? settings,
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
    LogSettings? settings,
  }) {
    logPrint(Level.warning, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.error].
  void e(
    String? message, {
    String? title,
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    logPrint(Level.error, message,
        title: title,
        error: error,
        stackTrace: stackTrace,
        tag: tag,
        settings: settings);
  }

  void logPrint(
    Level level,
    String? message, {
    String? title,
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    message ??= '<null>';
    if (message.isEmpty) message = '<empty>';
    settings ??= logSettings;

    final record = SimpleLogRecord(
      message: message,
      level: level,
      tag: tag ?? '',
      settings: settings,
      error: error,
      stackTrace: stackTrace,
    );
    logTyped(record, settings: settings);
  }

  void logTyped(
    LogRecord record, {
    LogSettings? settings,
  }) {
    records.value.add(record);
    if ((settings ?? logSettings).printLog) {
      _logger.log(record.level, record.generatePrint(), time: record.time);
    }
    if (!types.value.contains(record.type)) types.value.add(record.type);
  }

  void setupErrorCollector({bool printLog = true}) {
    FlutterError.onError = (details) {
      e(
        details.exception.toString(),
        title: '[FlutterError] Unhandled Exception',
        error: details.exception,
        stackTrace: details.stack,
        settings: logSettings.copyWith(printLog: printLog),
      );
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      e(
        error.toString(),
        title: '[PlatformDispatcher] Unhandled Exception',
        error: error,
        stackTrace: stack,
        settings: logSettings.copyWith(printLog: printLog),
      );
      return true;
    };
  }
}
