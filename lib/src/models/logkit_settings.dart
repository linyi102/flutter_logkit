import 'package:flutter_logkit/src/models/log_settings.dart';

class LogkitSettings extends LogSettings {
  final int? maxLogCount;
  final bool disableAttachOverlay;
  final bool disableRecordLog;

  const LogkitSettings({
    this.maxLogCount = 1000,
    this.disableAttachOverlay = false,
    this.disableRecordLog = false,
    super.printToConsole,
    super.printTime,
  });
}
