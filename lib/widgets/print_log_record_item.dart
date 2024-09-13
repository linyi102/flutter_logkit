import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/print_log_record.dart';
import 'package:flutter_logkit/utils/clipboard.dart';

class PrintLogRecordItem extends StatelessWidget {
  const PrintLogRecordItem(this.record, {super.key});
  final PrintLogRecord record;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        record.message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(record.formatedTime),
      trailing: Text(record.level.name),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(record.level.name),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(record.message),
                  const SizedBox(height: 10),
                  Text(
                    record.formatedTime,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    ClipboardUtil.copy(
                      context: context,
                      text: record.message,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('复制'))
            ],
          ),
        );
      },
    );
  }
}
