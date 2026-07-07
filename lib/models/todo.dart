import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

/// Data model for a single task, persisted with Hive.
@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  int timeHour;

  @HiveField(6)
  int timeMinute;

  @HiveField(7)
  DateTime date;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
    DateTime? createdAt,
    TimeOfDay? time,
    DateTime? date,
  })  : createdAt = createdAt ?? DateTime.now(),
        timeHour = (time ?? TimeOfDay.now()).hour,
        timeMinute = (time ?? TimeOfDay.now()).minute,
        date = date ?? DateTime.now();

  /// Convenience getter/setter for TimeOfDay.
  TimeOfDay get time => TimeOfDay(hour: timeHour, minute: timeMinute);
  set time(TimeOfDay t) {
    timeHour = t.hour;
    timeMinute = t.minute;
  }
}
