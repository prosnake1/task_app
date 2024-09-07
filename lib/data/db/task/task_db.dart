import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/domain/task/task.dart';

class TaskDB {
  TaskDB({required this.name});
  final String name;
  Future<List<Task>> fetchTaskData() async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('lists')
        .child(name);
    List<Task> tasksList = [];
    try {
      DatabaseEvent event = await databaseRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          Task film = Task(
              name: value['kinopoiskId'],
              date: value['filmName'],
              desc: value['desc'],
              notification: value['notification'],
              time: value['posterUrl']);
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
