import 'dart:convert';

class PrintLogSettings {
  final bool printLog;
  final bool printTime;
  final bool printTopic;

  const PrintLogSettings({
    this.printLog = true,
    this.printTime = true,
    this.printTopic = true,
  });

  PrintLogSettings copyWith({
    bool? printLog,
    bool? printTime,
    bool? printTopic,
  }) {
    return PrintLogSettings(
      printLog: printLog ?? this.printLog,
      printTime: printTime ?? this.printTime,
      printTopic: printTopic ?? this.printTopic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'printLog': printLog,
      'printTime': printTime,
      'printTopic': printTopic,
    };
  }

  factory PrintLogSettings.fromMap(Map<String, dynamic> map) {
    return PrintLogSettings(
      printLog: map['printLog'] as bool,
      printTime: map['printTime'] as bool,
      printTopic: map['printTopic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrintLogSettings.fromJson(String source) =>
      PrintLogSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PrintLogSettings(printLog: $printLog, printTime: $printTime, printTopic: $printTopic)';

  @override
  bool operator ==(covariant PrintLogSettings other) {
    if (identical(this, other)) return true;

    return other.printLog == printLog &&
        other.printTime == printTime &&
        other.printTopic == printTopic;
  }

  @override
  int get hashCode =>
      printLog.hashCode ^ printTime.hashCode ^ printTopic.hashCode;
}
