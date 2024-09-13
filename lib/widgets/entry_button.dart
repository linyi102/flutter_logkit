import 'package:flutter/material.dart';
import 'package:flutter_logkit/logger.dart';
import 'package:flutter_logkit/pages/log_page.dart';

class DraggableEntryButton extends StatefulWidget {
  const DraggableEntryButton({super.key, required this.logger});
  final LogkitLogger logger;

  @override
  State<DraggableEntryButton> createState() => _DraggableEntryButtonState();
}

class _DraggableEntryButtonState extends State<DraggableEntryButton> {
  double dx = 0, dy = 0;
  bool isOpened = false;

  final buttonSize = 36.0;
  late final halfButtonSize = buttonSize / 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      setState(() {
        dx = screenSize.width - 20 - buttonSize;
        dy = screenSize.height - 20 - buttonSize;
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
          child: _buildIcon(),
        ),
        onDragUpdate: (details) {
          final screenSize = MediaQuery.of(context).size;
          setState(() {
            dx = (dx + details.delta.dx)
                .clamp(-halfButtonSize, screenSize.width - halfButtonSize);
            dy = (dy + details.delta.dy)
                .clamp(-halfButtonSize, screenSize.height - halfButtonSize);
          });
        },
      ),
    );
  }

  Widget _buildIcon() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.bug_report),
      ),
    );
  }
}
