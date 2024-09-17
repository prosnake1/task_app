import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/data/db/task/requests.dart';
import 'package:task_app/domain/task/task_db.dart';
import 'package:task_app/domain/task/model.dart';

part 'tasks_list_event.dart';
part 'tasks_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  TasksListBloc(this._repository) : super(TasksListInitial()) {
    on<LoadTasks>(_loadList);
    on<AddTask>(_addTask);
    on<RemoveTask>(_removeTask);
  }
  final TaskRepository _repository;
  Future<void> _loadList(LoadTasks event, Emitter<TasksListState> emit) async {
    try {
      emit(TasksListLoading());
      if (FirebaseAuth.instance.currentUser != null) {
        emit(LoadedTasksList(tasks: await fetchTaskData(event.name)));
      }
    } catch (e, st) {
      emit(TasksListFailure(error: e));
      GetIt.I.get<Talker>().handle(e, st);
    }
  }

  Future<void> _addTask(AddTask event, Emitter<TasksListState> emit) async {
    try {
      emit(TasksListLoading());
      _repository.add(event.name, event.desc, event.time, event.parent);
      emit(LoadedTasksList(tasks: await fetchTaskData(event.parent)));
    } catch (e, st) {
      emit(TasksListFailure(error: e));
      GetIt.I.get<Talker>().handle(e, st);
    }
  }

  Future<void> _removeTask(
      RemoveTask event, Emitter<TasksListState> emit) async {
    try {
      _repository.remove(event.name, event.parent);
      emit(LoadedTasksList(tasks: await fetchTaskData(event.parent)));
    } catch (e, st) {
      emit(TasksListFailure(error: e));
      GetIt.I.get<Talker>().handle(e, st);
    }
  }
}
