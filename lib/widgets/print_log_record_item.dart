import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/print_log_record.dart';

class PrintLogRecordItem extends StatelessWidget {
  const PrintLogRecordItem(this.record, {super.key});
  final PrintLogRecord record;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(record.message),
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
          ),
        );
      },
    );
  }
}
