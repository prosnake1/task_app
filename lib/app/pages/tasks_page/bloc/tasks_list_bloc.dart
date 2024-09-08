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
  }
  final DatabaseReference listRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('lists')
      .child('tasks');
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
}
