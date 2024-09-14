import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/utils/clipboard.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RecordLogDetailPage extends StatelessWidget {
  const RecordLogDetailPage({
    super.key,
    required this.record,
  });

  final LogRecord record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (record.title.isNotEmpty) Text(record.title),
            Text(
              '${record.level.name} | ${record.formatedTime}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _copyMessage(context),
            icon: const Icon(Icons.copy_all),
          ),
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Markdown(
        data: record.message,
        selectable: true,
        softLineBreak: true,
      ),
    );
  }

  void _copyMessage(BuildContext context) {
    ClipboardUtil.copy(
      context: context,
      text: record.message,
    );
  }
}
