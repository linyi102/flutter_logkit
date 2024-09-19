import 'package:flutter/material.dart';

class FilterSearchView extends StatefulWidget {
  const FilterSearchView({
    super.key,
    required this.title,
    this.initialValue,
    required this.onSubmit,
  });
  final String title;
  final String? initialValue;
  final ValueChanged<String?> onSubmit;

  @override
  State<FilterSearchView> createState() => _FilterSearchViewState();
}

class _FilterSearchViewState extends State<FilterSearchView> {
  late final controller = TextEditingController(text: widget.initialValue);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onSubmit(null);
          },
          child: const Text('清除'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onSubmit(controller.text.trim());
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
