import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logger;

enum LogLevel {
  all(0),
  trace(1000, color: Colors.grey),
  debug(2000, color: Colors.blueGrey),
  info(3000, color: Colors.blue),
  warning(4000, color: Colors.orange),
  error(5000, color: Colors.redAccent),
  fatal(6000, color: Colors.red);

  final int value;
  final Color? color;

  const LogLevel(this.value, {this.color});

  static LogLevel fromLoggerLevel(logger.Level level) {
    return values.firstWhere((e) => e.value == level.value);
  }

  logger.Level toLoggerLevel() {
    return logger.Level.values.firstWhere((e) => e.value == value);
  }
}
