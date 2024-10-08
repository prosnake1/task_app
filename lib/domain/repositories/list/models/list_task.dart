import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_task.g.dart';

@JsonSerializable()
class ListTask {
  ListTask({required this.name, required this.id});
  final String name;
  final String id;
  ListTask.fromSnapshot(DataSnapshot snapshot, this.id)
      : name = (snapshot.value as Map<String, dynamic>?)?['name'] ?? '';
  factory ListTask.fromJson(Map<String, dynamic> json) =>
      _$ListTaskFromJson(json);

  Map<String, dynamic> toJson() => _$ListTaskToJson(this);
}
