import 'package:flutter/material.dart';

class LogFilterItem<T> extends StatelessWidget {
  const LogFilterItem({
    super.key,
    required this.title,
    this.buttonText,
    required this.fetchOptions,
    this.genLabel,
    required this.selectedOption,
    required this.onSelected,
  });
  final String title;
  final String? buttonText;
  final List<T> Function() fetchOptions;
  final String? Function(T option)? genLabel;
  final T? selectedOption;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () {
          final options = fetchOptions();
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              clipBehavior: Clip.antiAlias,
              builder: (context) => _buildOptionsView(options));
        },
        style: ButtonStyle(
          backgroundColor: selectedOption != null
              ? MaterialStatePropertyAll(
                  Theme.of(context).primaryColor.withOpacity(0.1))
              : null,
        ),
        child: Row(
          children: [
            Text(buttonText ?? title),
            if (selectedOption != null) _buildClearButton(context)
          ],
        ),
      ),
    );
  }

  Container _buildClearButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: GestureDetector(
        onTap: () => onSelected(null),
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

  Scaffold _buildOptionsView(List<T> options) {
    T? selectedOption = this.selectedOption;
    return Scaffold(
      appBar: AppBar(title: Text(title), automaticallyImplyLeading: false),
      body: StatefulBuilder(
        builder: (context, update) => ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return RadioListTile(
              title: Text(genLabel?.call(option) ?? option.toString()),
              toggleable: true,
              onChanged: (v) {
                update(() {
                  selectedOption = v;
                });
                onSelected(v);
              },
              groupValue: selectedOption,
              value: option,
            );
          },
        ),
      ),
    );
  }
}
