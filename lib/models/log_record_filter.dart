import 'package:flutter_logkit/models/log_level.dart';

class LogRecordFilter {
  LogLevel? level;
  String? type;
  String? tag;

  LogRecordFilter({
    this.level,
    this.type,
    this.tag,
  });

  LogRecordFilter copyWith({
    LogLevel? level,
    String? type,
    String? tag,
  }) {
    return LogRecordFilter(
      level: level ?? this.level,
      type: type ?? this.type,
      tag: tag ?? this.tag,
    );
  }

  @override
  String toString() => 'LogRecordFilter(level: $level, type: $type, tag: $tag)';

  @override
  bool operator ==(covariant LogRecordFilter other) {
    if (identical(this, other)) return true;

    return other.level == level && other.type == type && other.tag == tag;
  }

  @override
  int get hashCode => level.hashCode ^ type.hashCode ^ tag.hashCode;
}
