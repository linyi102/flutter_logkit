import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/utils/clipboard.dart';

class LogRecordItem extends StatelessWidget {
  const LogRecordItem(this.record, {super.key});
  final LogRecord record;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        record.title.isNotEmpty ? record.title : record.message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (record.title.isNotEmpty) Text(record.message, maxLines: 3),
          Row(
            children: [
              Text(
                record.level.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 10),
              Text(
                record.formatedTime,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          )
        ],
      ),
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
