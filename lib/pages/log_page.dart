import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/models/log_level.dart';
import 'package:flutter_logkit/widgets/log_filter_item.dart';
import 'package:flutter_logkit/widgets/log_record_item.dart';

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
                  if (v == null) {
                    widget.logger.filter.value =
                        (filter..level = null).copyWith();
                  } else {
                    widget.logger.filter.value = filter.copyWith(level: v);
                  }
                },
              ),
              LogFilterItem(
                title: 'Type',
                buttonText: filter.type ?? 'Type',
                fetchOptions: () => widget.logger.types.value,
                selectedOption: filter.type,
                onSelected: (v) {
                  if (v == null) {
                    widget.logger.filter.value =
                        (filter..type = null).copyWith();
                  } else {
                    widget.logger.filter.value = filter.copyWith(type: v);
                  }
                },
              ),
              LogFilterItem(
                title: 'Tag',
                buttonText: filter.tag ?? 'Tag',
                fetchOptions: () => widget.logger.tags.value,
                selectedOption: filter.tag,
                onSelected: (v) {
                  // TODO 选中后，关闭选择面板，再次打开取消选中时不会触发buttonText重绘
                  if (v == null) {
                    widget.logger.filter.value =
                        (filter..tag = null).copyWith();
                  } else {
                    widget.logger.filter.value = filter.copyWith(tag: v);
                  }
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
        final filteredRecords = widget.logger.records.value.where((record) {
          final filter = widget.logger.filter.value;
          if (filter.level == null &&
              filter.type == null &&
              filter.tag == null) {
            return true;
          }
          return (filter.level == null ? true : record.level == filter.level) &&
              (filter.type == null ? true : record.type == filter.type) &&
              (filter.tag == null ? true : record.tag == filter.tag);
        }).toList();

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
