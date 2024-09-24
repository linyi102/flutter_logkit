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
