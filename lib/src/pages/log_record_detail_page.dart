import 'package:flutter/material.dart';
import 'package:flutter_logkit/src/models/log_record.dart';
import 'package:flutter_logkit/src/utils/clipboard.dart';
import 'package:flutter_logkit/src/utils/pretty.dart';
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
        title: Text(
          '${record.level.name.toUpperCase()} | ${record.type}',
        ),
        actions: [
          IconButton(
            onPressed: () => _copyMessage(context),
            icon: const Icon(Icons.copy_all),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Markdown(
              data: [
                record.message,
                if (record.error != null)
                  'Error'.mdH3 + record.error.toString(),
                if (record.stackTrace != null)
                  'Stacktrace'.mdH3 + record.stackTrace.toString(),
              ].join(),
              selectable: true,
              softLineBreak: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'at ${record.formatedTime}${record.tag.isNotEmpty ? ' in ${record.tag}' : ''}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.5,
                  ),
            ),
          ),
        ],
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
