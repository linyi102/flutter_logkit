import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/src/pages/log_page.dart';

class DraggableEntryButton extends StatefulWidget {
  const DraggableEntryButton({super.key, required this.logger});
  final LogkitLogger logger;

  @override
  State<DraggableEntryButton> createState() => _DraggableEntryButtonState();
}

class _DraggableEntryButtonState extends State<DraggableEntryButton> {
  bool isOpened = false;
  Offset? buttonOffset;
  Size buttonSize = const Size(40, 40);
  final buttonKey = GlobalKey(debugLabel: 'log_entry_button');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      buttonSize = buttonKey.currentContext?.size ?? buttonSize;

      final calOffset =
          widget.logger.logkitSettings.entryIconOffset ?? _calInitialIconOffset;
      setState(() {
        buttonOffset = calOffset(screenSize, buttonSize);
      });
    });
  }

  Offset _calInitialIconOffset(Size screenSize, Size buttonSize) {
    return Offset(
      screenSize.width - 20 - buttonSize.width,
      screenSize.height - 20 - buttonSize.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (buttonOffset == null) return const SizedBox();

    return Positioned(
      left: buttonOffset?.dx,
      top: buttonOffset?.dy,
      child: AnimatedScale(
        scale: isOpened ? 0 : 1,
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 300),
        child: _buildDraggableIcon(context),
      ),
    );
  }

  Widget _buildDraggableIcon(BuildContext context) {
    return Draggable(
      feedback: _buildIcon(),
      child: GestureDetector(
        key: buttonKey,
        onTap: _toLogPage,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: _buildIcon(),
        ),
      ),
      onDragUpdate: (details) {
        final screenSize = MediaQuery.of(context).size;
        final halfButtonSize = buttonSize / 2;
        final dx = buttonOffset?.dx ?? 0, dy = buttonOffset?.dy ?? 0;
        final newDx = (dx + details.delta.dx).clamp(
            -halfButtonSize.width, screenSize.width - halfButtonSize.width);
        final newDy = (dy + details.delta.dy).clamp(
            -halfButtonSize.height, screenSize.height - halfButtonSize.height);
        setState(() {
          buttonOffset = Offset(newDx, newDy);
        });
      },
    );
  }

  Future<void> _toLogPage() async {
    setState(() {
      isOpened = true;
    });
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LogPage(logger: widget.logger)));
    setState(() {
      isOpened = false;
    });
  }

  Widget _buildIcon() {
    final icon = widget.logger.logkitSettings.entryIconBuilder?.call();
    if (icon != null) return icon;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          ),
        ],
      ),
      child: const Center(child: Icon(Icons.bug_report, color: Colors.white)),
    );
  }
}
