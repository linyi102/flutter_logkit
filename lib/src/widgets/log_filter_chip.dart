import 'package:flutter/material.dart';

class LogFilterChip<T> extends StatelessWidget {
  const LogFilterChip({
    super.key,
    required this.title,
    required this.onTap,
    this.filtered = false,
    required this.onClear,
  });
  final String title;
  final VoidCallback onTap;
  final bool filtered;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: filtered
              ? MaterialStatePropertyAll(
                  Theme.of(context).primaryColor.withOpacity(0.1))
              : null,
          visualDensity: const VisualDensity(vertical: -2),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16)),
        ),
        child: Row(
          children: [
            Text(title),
            if (filtered) _buildClearButton(context),
          ],
        ),
      ),
    );
  }

  Container _buildClearButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: GestureDetector(
        onTap: onClear,
        child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, size: 14),
        ),
      ),
    );
  }
}
