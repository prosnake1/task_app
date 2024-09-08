part of 'tasks_list_bloc.dart';

abstract class TasksListEvent {}

class LoadTasks extends TasksListEvent {
  LoadTasks({required this.name});
  final String name;
}
