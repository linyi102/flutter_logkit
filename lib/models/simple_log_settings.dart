import 'dart:convert';

class SimpleLogSettings {
  final bool printLog;
  final bool printTime;
  final bool printTopic;

  const SimpleLogSettings({
    this.printLog = true,
    this.printTime = true,
    this.printTopic = true,
  });

  SimpleLogSettings copyWith({
    bool? printLog,
    bool? printTime,
    bool? printTopic,
  }) {
    return SimpleLogSettings(
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

  factory SimpleLogSettings.fromMap(Map<String, dynamic> map) {
    return SimpleLogSettings(
      printLog: map['printLog'] as bool,
      printTime: map['printTime'] as bool,
      printTopic: map['printTopic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleLogSettings.fromJson(String source) =>
      SimpleLogSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SimpleLogSettings(printLog: $printLog, printTime: $printTime, printTopic: $printTopic)';

  @override
  bool operator ==(covariant SimpleLogSettings other) {
    if (identical(this, other)) return true;

    return other.printLog == printLog &&
        other.printTime == printTime &&
        other.printTopic == printTopic;
  }

  @override
  int get hashCode =>
      printLog.hashCode ^ printTime.hashCode ^ printTopic.hashCode;
}
