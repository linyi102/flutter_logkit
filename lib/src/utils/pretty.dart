import 'dart:convert';

extension JsonPrettyExtension on Object? {
  String get prettyJson {
    try {
      return const JsonEncoder.withIndent('  ').convert(
        this is String ? jsonDecode(this as String) : this,
      );
    } catch (_) {
      return toString();
    }
  }
}

extension MarkdownPrettyExtension on String {
  String get mdCodeblock {
    return '```\n$this\n```';
  }

  String get mdH3 {
    return mdHead(3);
  }

  String mdHead(int level) {
    return '\n${'#' * level} $this\n';
  }
}
