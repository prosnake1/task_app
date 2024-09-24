import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/domain/repositories/task/models/task.dart';
import 'package:task_app/domain/repositories/task/task_repository_interface.dart';

class TaskRepository implements AbstractTaskRepository {
  @override
  Future<List<Task>> fetchTaskData(String name) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('lists')
        .child(name)
        .child('tasks');
    List<Task> tasksList = [];
    try {
      DatabaseEvent event = await databaseRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        GetIt.I.get<Talker>().debug(values);
        values.forEach((key, value) {
          Task film = Task(
              name: value['name'], desc: value['desc'], time: value['time']);

          tasksList.add(film);
        });
      } else {
        GetIt.I<Talker>().debug('Data in Collection is Empty!');
      }
    } catch (e) {
      throw Error;
    }
    return tasksList;
  }
}
