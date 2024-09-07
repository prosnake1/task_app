part of 'list_bloc.dart';

abstract class ListEvent {}

class LoadList extends ListEvent {}

class AddList extends ListEvent {
  AddList({required this.name});
  final String name;
}

class RemoveList extends ListEvent {
  RemoveList({required this.name});
  final String name;
}
