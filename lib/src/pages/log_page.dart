import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/src/utils/utils.dart';
import 'package:flutter_logkit/src/widgets/widgets.dart';

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
              LogFilterChip(
                title: filter.level?.name.toUpperCase() ?? 'Level',
                filtered: filter.level != null,
                onClear: () {
                  widget.logger.filter.value =
                      filter.copyWithNullable(level: () => null);
                },
                onTap: () {
                  showCommonBottomSheet(
                    context: context,
                    builder: (context) => FilterOptionsView(
                      title: 'Level',
                      options: LogLevel.values,
                      selectedOption: filter.level,
                      labelGenerator: (option) => option.name.toUpperCase(),
                      trailingGenerator: (option) =>
                          _buildFilteredNumber((e) => e.level == option),
                      onSelected: (v) {
                        widget.logger.filter.value =
                            filter.copyWithNullable(level: () => v);
                      },
                    ),
                  );
                },
              ),
              LogFilterChip(
                title: filter.type ?? 'Type',
                filtered: filter.type?.isNotEmpty == true,
                onClear: () {
                  widget.logger.filter.value =
                      filter.copyWithNullable(type: () => null);
                },
                onTap: () {
                  showCommonBottomSheet(
                    context: context,
                    builder: (context) => FilterOptionsView(
                      title: 'Type',
                      options: widget.logger.types.value,
                      selectedOption: filter.type,
                      trailingGenerator: (option) =>
                          _buildFilteredNumber((e) => e.type == option),
                      onSelected: (v) {
                        widget.logger.filter.value =
                            filter.copyWithNullable(type: () => v);
                      },
                    ),
                  );
                },
              ),
              LogFilterChip(
                title: filter.tag ?? 'Tag',
                filtered: filter.tag?.isNotEmpty == true,
                onClear: () {
                  widget.logger.filter.value =
                      filter.copyWithNullable(tag: () => null);
                },
                onTap: () {
                  showCommonBottomSheet(
                    context: context,
                    builder: (context) => FilterOptionsView(
                      title: 'Tag',
                      options: widget.logger.tags.value,
                      selectedOption: filter.tag,
                      trailingGenerator: (option) =>
                          _buildFilteredNumber((e) => e.tag == option),
                      onSelected: (v) {
                        widget.logger.filter.value =
                            filter.copyWithNullable(tag: () => v);
                      },
                    ),
                  );
                },
              ),
              LogFilterChip(
                title: filter.keyword ?? 'Keyword',
                filtered: filter.keyword?.isNotEmpty == true,
                onClear: () {
                  widget.logger.filter.value =
                      filter.copyWithNullable(keyword: () => null);
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterSearchView(
                      title: 'Keyword',
                      initialValue: filter.keyword,
                      onSubmit: (String? value) {
                        widget.logger.filter.value =
                            filter.copyWithNullable(keyword: () => value);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredNumber(bool Function(LogRecord) test) {
    return Text(widget.logger.records.value.where(test).length.toString());
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
