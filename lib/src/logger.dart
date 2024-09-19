import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logkit/src/models/log_level.dart';
import 'package:flutter_logkit/src/models/log_record.dart';
import 'package:flutter_logkit/src/models/log_record_filter.dart';
import 'package:flutter_logkit/src/models/simple_log_record.dart';
import 'package:flutter_logkit/src/models/log_settings.dart';
import 'package:flutter_logkit/src/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';

class LogkitLogger {
  late final Logger _logger;
  final _records = ValueNotifier(<LogRecord>[]);
  final _types = ValueNotifier(<String>[]);
  final _tags = ValueNotifier(<String>[]);
  final _filter = ValueNotifier(const LogRecordFilter());
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

  List<LogRecord> filterRecords() {
    return records.value
        .where((record) => filter.value.isMatch(record))
        .toList();
  }

  void trace(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    log(LogLevel.trace, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void debug(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    log(LogLevel.debug, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void info(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    log(LogLevel.info, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void warning(
    String? message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    log(LogLevel.warning, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void error(
    String? message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    LogSettings? settings,
  }) {
    log(LogLevel.error, message,
        error: error, stackTrace: stackTrace, tag: tag, settings: settings);
  }

  void log(
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
      error(
        'Unhandled Exception',
        error: details.exception,
        stackTrace: details.stack,
        settings: logSettings.copyWith(printLog: printLog),
        tag: 'FlutterError',
      );
    };
    PlatformDispatcher.instance.onError = (err, stack) {
      error(
        'Unhandled Exception',
        error: err,
        stackTrace: stack,
        settings: logSettings.copyWith(printLog: printLog),
        tag: 'PlatformDispatcher',
      );
      return true;
    };
  }
}
