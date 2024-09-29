import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/data/services/list/list_service_interface.dart';
import 'package:task_app/domain/repositories/list/list_repository_interface.dart';
import 'package:task_app/domain/repositories/list/models/list_task.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(this._repository) : super(ListInitial()) {
    on<LoadList>(_loadList);
    on<AddList>(_addList);
    on<RemoveList>(_removeList);
  }
  final AbstractListRepository _repository;
  final service = GetIt.I.get<AbstractListService>();
  Future<void> _loadList(LoadList event, Emitter<ListState> emit) async {
    try {
      emit(ListLoading());
      if (FirebaseAuth.instance.currentUser != null) {
        emit(LoadedList(list: await _repository.getLists()));
      }
    } catch (e, st) {
      emit(ListFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> _addList(AddList event, Emitter<ListState> emit) async {
    try {
      emit(ListLoading());
      service.add(event.name);
      emit(LoadedList(list: await _repository.getLists()));
    } catch (e, st) {
      emit(ListFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> _removeList(RemoveList event, Emitter<ListState> emit) async {
    try {
      service.remove(event.name);
      emit(LoadedList(list: await _repository.getLists()));
    } catch (e, st) {
      emit(ListFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
