import 'package:flutter/material.dart';
import 'package:flutter_logkit/src/logger.dart';
import 'package:flutter_logkit/src/pages/log_page.dart';

class DraggableEntryButton extends StatefulWidget {
  const DraggableEntryButton({super.key, required this.logger});
  final LogkitLogger logger;

  @override
  State<DraggableEntryButton> createState() => _DraggableEntryButtonState();
}

class _DraggableEntryButtonState extends State<DraggableEntryButton> {
  double dx = 0, dy = 0;
  bool isOpened = false;

  Size buttonSize = const Size(40, 40);
  final buttonKey = GlobalKey(debugLabel: 'log_entry_button');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      buttonSize = buttonKey.currentContext?.size ?? buttonSize;
      setState(() {
        dx = screenSize.width - 20 - buttonSize.width;
        dy = screenSize.height - 20 - buttonSize.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOpened) return const SizedBox();

    return Positioned(
      left: dx,
      top: dy,
      child: Draggable(
        feedback: _buildIcon(),
        child: GestureDetector(
          key: buttonKey,
          onTap: () async {
            setState(() {
              isOpened = true;
            });
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LogPage(logger: widget.logger)));
            setState(() {
              isOpened = false;
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: _buildIcon(),
          ),
        ),
        onDragUpdate: (details) {
          final screenSize = MediaQuery.of(context).size;
          final halfButtonSize = buttonSize / 2;
          setState(() {
            dx = (dx + details.delta.dx).clamp(
                -halfButtonSize.width, screenSize.width - halfButtonSize.width);
            dy = (dy + details.delta.dy).clamp(-halfButtonSize.height,
                screenSize.height - halfButtonSize.height);
          });
        },
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.bug_report),
    );
  }
}
