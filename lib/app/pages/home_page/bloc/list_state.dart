part of 'list_bloc.dart';

abstract class ListState extends Equatable {}

class ListInitial extends ListState {
  @override
  List<Object?> get props => [];
}

class ListLoading extends ListState {
  @override
  List<Object?> get props => [];
}

class LoadedList extends ListState {
  LoadedList({required this.filmsList});
  final List<ListTask> filmsList;
  @override
  List<Object?> get props => [filmsList];
}

class ListFailure extends ListState {
  ListFailure({required this.exception});
  final Object? exception;
  @override
  List<Object?> get props => [exception];
}
