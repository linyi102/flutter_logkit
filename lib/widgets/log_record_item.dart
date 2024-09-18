import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/pages/log_record_detail_page.dart';

class LogRecordItem extends StatelessWidget {
  const LogRecordItem(this.record, {super.key});
  final LogRecord record;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      color: record.level.color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                  '${record.level.name.toUpperCase()} | ${record.type}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ))
              ],
            ),
            const SizedBox(height: 5),
            Text(
              record.message,
              maxLines: 3,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 5),
            Text(
              'at ${record.formatedTime}${record.tag.isNotEmpty ? ' in ${record.tag}' : ''}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            settings: const RouteSettings(name: 'log detail'),
            builder: (context) => RecordLogDetailPage(record: record)));
      },
    );
  }
}
