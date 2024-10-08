import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task(
      {required this.name,
      required this.desc,
      required this.time,
      required this.id});
  final String name;
  final String desc;
  final String time;
  final String id;
  Task.fromSnapshot(DataSnapshot snapshot)
      : name = (snapshot.value as Map<String, dynamic>?)?['name'],
        desc = (snapshot.value as Map<String, dynamic>?)?['desc'],
        time = (snapshot.value as Map<String, dynamic>?)?['time'],
        id = (snapshot.value as Map<String, dynamic>?)?['id'];
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
