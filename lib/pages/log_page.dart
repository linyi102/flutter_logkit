import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
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
      body: ValueListenableBuilder(
        valueListenable: widget.logger.records,
        builder: (context, records, child) => ListView.separated(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[records.length - 1 - index];
            return LogRecordItem(record);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 0.5,
          ),
        ),
      ),
    );
  }
}
