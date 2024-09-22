import 'package:flutter/widgets.dart';
import 'package:flutter_logkit/logkit.dart';

typedef EntryIconOffsetFunction = Offset Function(
    Size screenSize, Size buttonSize);

class LogkitSettings extends LogSettings {
  final int? maxLogCount;
  final bool disableAttachOverlay;
  final bool disableRecordLog;
  final Widget Function()? entryIconBuilder;
  final EntryIconOffsetFunction? entryIconOffset;

  const LogkitSettings({
    this.maxLogCount = 1000,
    this.disableAttachOverlay = false,
    this.disableRecordLog = false,
    this.entryIconBuilder,
    this.entryIconOffset,
    super.printToConsole,
    super.printTime,
  });
}
