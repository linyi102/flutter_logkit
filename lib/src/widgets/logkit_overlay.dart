import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/src/widgets/entry_button.dart';

class LogkitOverlay extends StatelessWidget {
  const LogkitOverlay._({required this.logger});
  static OverlayEntry? _overlayEntry;
  final LogkitLogger logger;

  static void attach({
    required BuildContext context,
    required LogkitLogger logger,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _overlayEntry =
          OverlayEntry(builder: (context) => LogkitOverlay._(logger: logger));
      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableEntryButton(logger: logger);
  }
}
