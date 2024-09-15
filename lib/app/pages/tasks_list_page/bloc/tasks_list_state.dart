part of 'tasks_list_bloc.dart';

abstract class TasksListState {}

class TasksListInitial extends TasksListState {}

class TasksListLoading extends TasksListState {}

class LoadedTasksList extends TasksListState {
  LoadedTasksList({required this.tasks});
  final List<Task> tasks;
}

class TasksListFailure extends TasksListState {
  TasksListFailure({required this.error});
  final Object? error;
}
