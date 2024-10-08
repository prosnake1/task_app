part of 'tasks_list_bloc.dart';

abstract class TasksListEvent extends Equatable {}

class LoadTasks extends TasksListEvent {
  LoadTasks({required this.name});
  final String name;

  @override
  List<Object?> get props => [name];
}

class AddTask extends TasksListEvent {
  AddTask({
    required this.parent,
    required this.name,
    required this.desc,
    this.time,
  });
  final String parent;
  final String name;
  final String desc;
  final String? time;

  @override
  List<Object?> get props => [parent, name, desc, time];
}

class RemoveTask extends TasksListEvent {
  RemoveTask({required this.id, required this.parent});
  final String id;
  final String parent;

  @override
  List<Object?> get props => [id, parent];
}
