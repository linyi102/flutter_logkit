import 'dart:convert';

class LogSettings {
  final bool printToConsole;
  final bool printTime;

  const LogSettings({
    this.printToConsole = true,
    this.printTime = true,
  });

  LogSettings copyWith({
    bool? printToConsole,
    bool? printTime,
  }) {
    return LogSettings(
      printToConsole: printToConsole ?? this.printToConsole,
      printTime: printTime ?? this.printTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'printToConsole': printToConsole,
      'printTime': printTime,
    };
  }

  factory LogSettings.fromMap(Map<String, dynamic> map) {
    return LogSettings(
      printToConsole: map['printToConsole'] as bool,
      printTime: map['printTime'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogSettings.fromJson(String source) =>
      LogSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogSettings(printToConsole: $printToConsole, printTime: $printTime)';

  @override
  bool operator ==(covariant LogSettings other) {
    if (identical(this, other)) return true;

    return other.printToConsole == printToConsole &&
        other.printTime == printTime;
  }

  @override
  int get hashCode => printToConsole.hashCode ^ printTime.hashCode;
}
