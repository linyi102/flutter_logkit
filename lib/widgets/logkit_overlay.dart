import 'package:flutter/material.dart';
import 'package:flutter_logkit/widgets/entry_button.dart';

class LogkitOverlay extends StatelessWidget {
  const LogkitOverlay._();
  static OverlayEntry? _overlayEntry;

  static void attach(BuildContext context) {
    _overlayEntry = OverlayEntry(builder: (context) => const LogkitOverlay._());
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return const DraggableEntryButton();
  }
}

