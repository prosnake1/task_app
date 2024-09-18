part of 'tasks_list_bloc.dart';

abstract class TasksListState extends Equatable {}

class TasksListInitial extends TasksListState {
  @override
  List<Object?> get props => [];
}

class TasksListLoading extends TasksListState {
  @override
  List<Object?> get props => [];
}

class LoadedTasksList extends TasksListState {
  LoadedTasksList({required this.tasks});
  final List<Task> tasks;
  @override
  List<Object?> get props => [tasks];
}

class TasksListFailure extends TasksListState {
  TasksListFailure({required this.error});
  final Object? error;
  @override
  List<Object?> get props => [error];
}
