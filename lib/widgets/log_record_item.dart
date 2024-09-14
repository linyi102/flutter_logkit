import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/pages/log_record_detail_page.dart';

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
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          clipBehavior: Clip.antiAlias,
          builder: (context) => RecordLogDetailPage(record: record),
        );
      },
    );
  }
}
