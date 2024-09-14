import 'dart:convert';

class LogSettings {
  final bool printLog;
  final bool printTime;

  const LogSettings({
    this.printLog = true,
    this.printTime = true,
  });

  LogSettings copyWith({
    bool? printLog,
    bool? printTime,
  }) {
    return LogSettings(
      printLog: printLog ?? this.printLog,
      printTime: printTime ?? this.printTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'printLog': printLog,
      'printTime': printTime,
    };
  }

  factory LogSettings.fromMap(Map<String, dynamic> map) {
    return LogSettings(
      printLog: map['printLog'] as bool,
      printTime: map['printTime'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogSettings.fromJson(String source) =>
      LogSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogSettings(printLog: $printLog, printTime: $printTime)';

  @override
  bool operator ==(covariant LogSettings other) {
    if (identical(this, other)) return true;

    return other.printLog == printLog && other.printTime == printTime;
  }

  @override
  int get hashCode => printLog.hashCode ^ printTime.hashCode;
}
