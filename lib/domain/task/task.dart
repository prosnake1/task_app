import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task(
      {required this.name,
      required this.desc,
      required this.date,
      required this.time});
  final String name;
  final String desc;
  final String date;
  final String time;
  Task.fromSnapshot(DataSnapshot snapshot)
      : name = (snapshot.value as Map<String, dynamic>?)?['name'],
        date = (snapshot.value as Map<String, dynamic>?)?['date'],
        desc = (snapshot.value as Map<String, dynamic>?)?['desc'],
        time = (snapshot.value as Map<String, dynamic>?)?['time'];
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
