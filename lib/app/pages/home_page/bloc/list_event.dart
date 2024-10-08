part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {}

class LoadList extends ListEvent {
  @override
  List<Object?> get props => [];
}

class AddList extends ListEvent {
  AddList({required this.name});
  final String name;

  @override
  List<Object?> get props => [name];
}

class RemoveList extends ListEvent {
  RemoveList({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}
