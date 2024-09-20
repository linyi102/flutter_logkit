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
    if (_overlayEntry != null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.maybeOf(context);
      if (overlay == null) {
        logger.error('No Overlay widget found.');
        return;
      }

      _overlayEntry =
          OverlayEntry(builder: (context) => LogkitOverlay._(logger: logger));
      overlay.insert(_overlayEntry!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableEntryButton(logger: logger);
  }
}
