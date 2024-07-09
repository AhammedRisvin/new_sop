import 'package:hive_flutter/hive_flutter.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class Reminder extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String time;

  @HiveField(4)
  final String id;

  Reminder({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.id,
  });
}
