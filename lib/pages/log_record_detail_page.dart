import 'package:flutter/material.dart';
import 'package:flutter_logkit/models/log_record.dart';
import 'package:flutter_logkit/utils/clipboard.dart';
import 'package:flutter_logkit/utils/pretty.dart';
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
        title: Text(
          '${record.level.name.toUpperCase()} | ${record.type}',
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
        data: [
          // TODO 如何保证副标题可以显示error，但要避免message和error重复
          if (record.message != record.error.toString()) record.message,
          if (record.error != null) 'Error'.mdH3 + record.error.toString(),
          if (record.stackTrace != null)
            'Stacktrace'.mdH3 + record.stackTrace.toString(),
        ].join(),
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
