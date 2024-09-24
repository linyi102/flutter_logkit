import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_logkit/src/models/models.dart';
import 'package:flutter_logkit/src/utils/windows.dart';
import 'package:flutter_logkit/src/widgets/logkit_overlay.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

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
  final LogkitSettings logkitSettings;

  LogkitLogger({
    this.logkitSettings = const LogkitSettings(),
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
    settings ??= logkitSettings;

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
    if (logkitSettings.disableRecordLog) return;

    if ((settings ?? logkitSettings).printToConsole) {
      _logger.log(record.level.toLoggerLevel(), record.consoleMessage,
          time: record.time);
    }

    records.value = [...records.value, record];
    _updateAfterAddRecord(record);

    final maxLogCount = logkitSettings.maxLogCount;
    if (maxLogCount != null &&
        records.value.length > maxLogCount &&
        records.value.isNotEmpty) {
      final removedRecord = records.value.removeAt(0);
      _updateAfterRemoveRecord(removedRecord);
    }
  }

  void _updateAfterRemoveRecord(LogRecord record) {
    if (records.value.indexWhere((e) => e.type == record.type) < 0) {
      types.value = types.value.where((e) => e != record.type).toList();
    }
    if (records.value.indexWhere((e) => e.tag == record.tag) < 0) {
      tags.value = tags.value.where((e) => e != record.tag).toList();
    }
  }

  void _updateAfterAddRecord(LogRecord record) {
    if (record.type.isNotEmpty && !types.value.contains(record.type)) {
      types.value = [...types.value, record.type];
    }
    if (record.tag.isNotEmpty && !tags.value.contains(record.tag)) {
      tags.value = [...tags.value, record.tag];
    }
  }

  Future<void> shareLogs() async {
    final dir = await getTemporaryDirectory();
    final time = DateTime.now().toString().replaceAll(':', '-');
    final fileName = 'logkit_$time.log';
    final file = await File(p.join(dir.path, 'logkit_logs', fileName))
        .create(recursive: true);
    final io = file.openWrite();
    try {
      for (final record in records.value) {
        io.writeln(record.fullMessage);
      }
    } finally {
      await io.flush();
      await io.close();
    }
    if (Platform.isWindows) {
      WindowsUtil.locateFile(file.path);
    } else {
      Share.shareXFiles([XFile(file.path)]).then((_) => file.delete());
    }
  }
}
