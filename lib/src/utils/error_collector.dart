import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_logkit/logkit.dart';

R? runLogkitZonedGuarded<R>(
  LogkitLogger logger,
  R Function() body, {
  bool printToConsole = true,
  Map<Object?, Object?>? zoneValues,
  ZoneSpecification? zoneSpecification,
}) {
  _setupErrorCollector(logger, printToConsole: printToConsole);
  return runZonedGuarded(
    body,
    (error, stack) {
      _log(logger, error, stack, tag: 'Zone', printToConsole: printToConsole);
    },
    zoneValues: zoneValues,
    zoneSpecification: zoneSpecification,
  );
}

void _setupErrorCollector(
  LogkitLogger logger, {
  bool printToConsole = true,
}) {
  FlutterError.onError = (details) {
    _log(logger, details.exception, details.stack,
        tag: 'FlutterError', printToConsole: printToConsole);
  };
  PlatformDispatcher.instance.onError = (err, stack) {
    _log(logger, err, stack,
        tag: 'PlatformDispatcher', printToConsole: printToConsole);
    return true;
  };
  if (!kIsWeb) {
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      final isolateError = pair as List<dynamic>;
      _log(logger, isolateError.first.toString(),
          StackTrace.fromString(isolateError.last.toString()),
          tag: 'Isolate', printToConsole: printToConsole);
    }).sendPort);
  }
}

void _log(
  LogkitLogger logger,
  Object err,
  StackTrace? stack, {
  required String tag,
  bool printToConsole = true,
}) {
  logger.logTyped(UnhandledErrorLogRecord(
    message: err.toString(),
    stackTrace: stack,
    tag: tag,
    settings: logger.logkitSettings.copyWith(printToConsole: printToConsole),
  ));
}
