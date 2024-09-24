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
  LoadedList({required this.list});
  final List<ListTask> list;
  @override
  List<Object?> get props => [list];
}

class ListFailure extends ListState {
  ListFailure({required this.exception});
  final Object? exception;
  @override
  List<Object?> get props => [exception];
}
