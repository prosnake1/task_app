part of 'tasks_list_bloc.dart';

abstract class TasksListEvent {}

class LoadTasks extends TasksListEvent {
  LoadTasks({required this.name});
  final String name;
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
}

class RemoveTask extends TasksListEvent {
  RemoveTask({required this.name, required this.parent});
  final String name;
  final String parent;
}
