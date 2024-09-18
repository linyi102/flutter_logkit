import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_level.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/models/log_record_filter.dart';
import 'package:flutter_logkit/models/simple_log_record.dart';
import 'package:flutter_logkit/models/log_settings.dart';
import 'package:flutter_logkit/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  final _types = ValueNotifier(<String>[]);
  final _tags = ValueNotifier(<String>[]);
  final _filter = ValueNotifier(LogRecordFilter());
  ValueNotifier<List<LogRecord>> get records => _records;
  ValueNotifier<List<String>> get types => _types;
  ValueNotifier<List<String>> get tags => _tags;
  ValueNotifier<LogRecordFilter> get filter => _filter;
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
    logPrint(LogLevel.trace, message,
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
    logPrint(LogLevel.debug, message,
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
    logPrint(LogLevel.info, message,
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
    logPrint(LogLevel.warning, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  /// Log a message at level [Level.error].
  void e(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    logPrint(LogLevel.error, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void logPrint(
    LogLevel level,
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    settings ??= logSettings;

    final record = SimpleLogRecord(
      message: message ?? '',
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
    records.value = [...records.value, record];
    if ((settings ?? logSettings).printLog) {
      _logger.log(record.level.toLoggerLevel(), record.generatePrint(),
          time: record.time);
    }
    if (!types.value.contains(record.type)) {
      types.value = [...types.value, record.type];
    }
    if (record.tag.isNotEmpty && !tags.value.contains(record.tag)) {
      tags.value = [...tags.value, record.tag];
    }
  }

  void setupErrorCollector({bool printLog = true}) {
    FlutterError.onError = (details) {
      e(
        'Unhandled Exception',
        error: details.exception,
        stackTrace: details.stack,
        settings: logSettings.copyWith(printLog: printLog),
        tag: 'FlutterError',
      );
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      e(
        'Unhandled Exception',
        error: error,
        stackTrace: stack,
        settings: logSettings.copyWith(printLog: printLog),
        tag: 'PlatformDispatcher',
      );
      return true;
    };
  }
}
