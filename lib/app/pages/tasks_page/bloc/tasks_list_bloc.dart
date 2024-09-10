import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/data/db/task/task_db.dart';
import 'package:task_app/domain/task/model.dart';

part 'tasks_list_event.dart';
part 'tasks_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  TasksListBloc() : super(TasksListInitial()) {
    on<LoadTasks>(_loadList);
    on<AddTask>(_addTask);
    on<RemoveTask>(_removeTask);
  }
  final DatabaseReference listRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('lists');
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
      if (FirebaseAuth.instance.currentUser != null) {
        await listRef.child(event.parent).child('tasks').child(event.name).set({
          'name': event.name,
          'desc': event.desc,
          'time': event.time,
        });
        emit(LoadedTasksList(tasks: await fetchTaskData(event.parent)));
      }
    } catch (e, st) {
      emit(TasksListFailure(error: e));
      GetIt.I.get<Talker>().handle(e, st);
    }
  }

  Future<void> _removeTask(
      RemoveTask event, Emitter<TasksListState> emit) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await listRef
            .child(event.parent)
            .child('tasks')
            .child(event.name)
            .remove();
        emit(LoadedTasksList(tasks: await fetchTaskData(event.parent)));
      }
    } catch (e, st) {
      emit(TasksListFailure(error: e));
      GetIt.I.get<Talker>().handle(e, st);
    }
  }
}
