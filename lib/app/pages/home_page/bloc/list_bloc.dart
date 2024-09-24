import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/data/db/list/requests.dart';
import 'package:task_app/domain/list/list_db.dart';
import 'package:task_app/domain/list/list_task.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(this._repository) : super(ListInitial()) {
    on<LoadList>(_loadList);
    on<AddList>(_addList);
    on<RemoveList>(_removeList);
  }
  final ListDataRepository _repository;
  Future<void> _loadList(LoadList event, Emitter<ListState> emit) async {
    try {
      emit(ListLoading());
      if (FirebaseAuth.instance.currentUser != null) {
        emit(LoadedList(list: await _repository.listFetchData()));
      }
    } catch (e, st) {
      emit(ListFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> _addList(AddList event, Emitter<ListState> emit) async {
    try {
      emit(ListLoading());
      ListRepository().add(event.name);
      emit(LoadedList(list: await _repository.listFetchData()));
    } catch (e, st) {
      emit(ListFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> _removeList(RemoveList event, Emitter<ListState> emit) async {
    try {
      ListRepository().remove(event.name);
      emit(LoadedList(list: await _repository.listFetchData()));
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
