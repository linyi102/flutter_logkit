import 'package:flutter_logkit/src/models/log_settings.dart';

class LogkitSettings extends LogSettings {
  final int? maxLogCount;

  const LogkitSettings({
    this.maxLogCount = 1000,
    super.printToConsole,
    super.printTime,
  });
}
