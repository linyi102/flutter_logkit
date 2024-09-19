import 'package:flutter/material.dart';

class FilterOptionsView<T> extends StatefulWidget {
  const FilterOptionsView({
    super.key,
    required this.title,
    required this.options,
    this.labelGenerator,
    this.selectedOption,
    required this.onSelected,
  });
  final String title;
  final List<T> options;
  final String Function(T option)? labelGenerator;
  final T? selectedOption;
  final ValueChanged<T?> onSelected;

  @override
  State<FilterOptionsView> createState() => _FilterOptionsViewState<T>();
}

class _FilterOptionsViewState<T> extends State<FilterOptionsView<T>> {
  late T? selectedOption = widget.selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.title), automaticallyImplyLeading: false),
      body: ListView.builder(
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          return RadioListTile<T>(
            title: Text(widget.labelGenerator?.call(option) ?? option.toString()),
            toggleable: true,
            onChanged: (v) {
              setState(() {
                selectedOption = v;
              });
              widget.onSelected(v);
            },
            groupValue: selectedOption,
            value: option,
          );
        },
      ),
    );
  }
}
