import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/src/widgets/log_filter_item.dart';
import 'package:flutter_logkit/src/widgets/log_record_item.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key, required this.logger});
  final LogkitLogger logger;

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOG')),
      body: Column(
        children: [
          _buildFilter(),
          Expanded(child: _buildRecords()),
        ],
      ),
    );
  }

  /// TODO keyword
  Widget _buildFilter() {
    return Container(
      height: 32,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder(
          valueListenable: widget.logger.filter,
          builder: (context, filter, child) => Row(
            children: [
              LogFilterItem(
                title: 'Level',
                buttonText: filter.level?.name.toUpperCase() ?? 'Level',
                fetchOptions: () => LogLevel.values,
                genLabel: (option) => option.name.toUpperCase(),
                selectedOption: filter.level,
                onSelected: (v) {
                  widget.logger.filter.value =
                      filter.copyWithNullable(level: () => v);
                },
              ),
              LogFilterItem(
                title: 'Type',
                buttonText: filter.type ?? 'Type',
                fetchOptions: () => widget.logger.types.value,
                selectedOption: filter.type,
                onSelected: (v) {
                  widget.logger.filter.value =
                      filter.copyWithNullable(type: () => v);
                },
              ),
              LogFilterItem(
                title: 'Tag',
                buttonText: filter.tag ?? 'Tag',
                fetchOptions: () => widget.logger.tags.value,
                selectedOption: filter.tag,
                onSelected: (v) {
                  widget.logger.filter.value =
                      filter.copyWithNullable(tag: () => v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecords() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        widget.logger.records,
        widget.logger.filter,
      ]),
      builder: (context, child) {
        final filteredRecords = widget.logger.filterRecords();
        return ListView.separated(
          itemCount: filteredRecords.length,
          itemBuilder: (context, index) {
            final record = filteredRecords[filteredRecords.length - 1 - index];
            return LogRecordItem(record);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 0.5,
          ),
        );
      },
    );
  }
}
