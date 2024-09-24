import 'package:flutter/material.dart';
import 'package:flutter_logkit/src/models/log_record.dart';
import 'package:flutter_logkit/src/utils/clipboard.dart';

class RecordLogDetailPage extends StatelessWidget {
  const RecordLogDetailPage({
    super.key,
    required this.record,
  });

  final LogRecord record;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(height: 3);

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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: record.message.trim()),
                    if (record.error != null) ...[
                      TextSpan(text: '\nError\n', style: titleStyle),
                      TextSpan(text: record.error?.toString()),
                    ],
                    if (record.stackTrace != null) ...[
                      TextSpan(text: '\nStacktrace\n', style: titleStyle),
                      TextSpan(text: record.stackTrace?.toString()),
                    ]
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'at ${record.formatedTime}${record.tag.isNotEmpty ? ' in ${record.tag}' : ''}',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).hintColor),
        ),
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
