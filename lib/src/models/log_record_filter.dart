import 'package:flutter/foundation.dart';
import 'package:flutter_logkit/src/models/log_level.dart';

@immutable
class LogRecordFilter {
  final LogLevel? level;
  final String? type;
  final String? tag;

  const LogRecordFilter({
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

  LogRecordFilter copyWithNullable({
    ValueGetter<LogLevel?>? level,
    ValueGetter<String?>? type,
    ValueGetter<String?>? tag,
  }) {
    return LogRecordFilter(
      level: level != null ? level() : this.level,
      type: type != null ? type() : this.type,
      tag: tag != null ? tag() : this.tag,
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
