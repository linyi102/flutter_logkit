import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';
import 'package:flutter_logkit/models/print_log_record.dart';
import 'package:flutter_logkit/widgets/print_log_record_item.dart';

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
        builder: (context, records, child) => ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[records.length - 1 - index];
            if (record is PrintLogRecord) {
              return PrintLogRecordItem(record);
            }

            return ListTile(
              title: Text('not supported record type: ${record.type}'),
            );
          },
        ),
      ),
    );
  }
}
