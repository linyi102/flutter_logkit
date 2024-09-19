import 'package:flutter/foundation.dart';
import 'package:flutter_logkit/src/models/models.dart';

@immutable
class LogRecordFilter {
  final LogLevel? level;
  final String? type;
  final String? tag;
  final String? keyword;

  const LogRecordFilter({
    this.level,
    this.type,
    this.tag,
    this.keyword,
  });

  bool isMatch(LogRecord record) {
    if (level == null && type == null && tag == null && keyword == null) {
      return true;
    }

    bool isBlank(String? val) => val == null || val.isEmpty;
    bool isMatchLevel() => level == null ? true : record.level == level;
    bool isMatchType() => isBlank(type) ? true : record.type == type;
    bool isMatchTag() => isBlank(tag) ? true : record.tag == tag;
    bool isMatchKeyword() => isBlank(keyword)
        ? true
        : record.fullMessage.toLowerCase().contains(keyword!.toLowerCase());

    return isMatchLevel() && isMatchType() && isMatchTag() && isMatchKeyword();
  }

  LogRecordFilter copyWith({
    LogLevel? level,
    String? type,
    String? tag,
    String? keyword,
  }) {
    return LogRecordFilter(
      level: level ?? this.level,
      type: type ?? this.type,
      tag: tag ?? this.tag,
      keyword: keyword ?? this.keyword,
    );
  }

  LogRecordFilter copyWithNullable({
    ValueGetter<LogLevel?>? level,
    ValueGetter<String?>? type,
    ValueGetter<String?>? tag,
    ValueGetter<String?>? keyword,
  }) {
    return LogRecordFilter(
      level: level != null ? level() : this.level,
      type: type != null ? type() : this.type,
      tag: tag != null ? tag() : this.tag,
      keyword: keyword != null ? keyword() : this.keyword,
    );
  }

  @override
  String toString() =>
      'LogRecordFilter(level: $level, type: $type, tag: $tag, keyword: $keyword)';

  @override
  bool operator ==(covariant LogRecordFilter other) {
    if (identical(this, other)) return true;

    return other.level == level &&
        other.type == type &&
        other.tag == tag &&
        other.keyword == keyword;
  }

  @override
  int get hashCode =>
      level.hashCode ^ type.hashCode ^ tag.hashCode ^ keyword.hashCode;
}
