import 'package:flutter/foundation.dart';
import 'package:flutter_logkit/logkit.dart';

/// Enable log in release version:
/// flutter build xxx --dart-define logging=true
const _enableLog = kDebugMode || bool.fromEnvironment('logging');

final logger = LogkitLogger(
  logkitSettings: const LogkitSettings(
    disableAttachOverlay: !_enableLog,
    disableRecordLog: !_enableLog,
    printToConsole: true,
    printTime: true,
    maxLogCount: 100,
  ),
)..setupErrorCollector();
