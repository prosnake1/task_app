part of 'list_bloc.dart';

abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class LoadedList extends ListState {
  LoadedList({required this.filmsList});
  final List<ListTask> filmsList;
}

class ListFailure extends ListState {
  ListFailure({required this.exception});
  final Object? exception;
}
