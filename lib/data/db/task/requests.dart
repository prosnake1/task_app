import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/notification/notification.dart';

class TaskRepository {
  final DatabaseReference listRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('lists');
  Future<void> add(
      String name, String desc, String? time, String parent) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await listRef.child(parent).child('tasks').child(name).set({
        'name': name,
        'desc': desc,
        'time': time,
      });
      if (time!.isNotEmpty) {
        int id = name.hashCode;
        NotificationService.scheduleNotification(
          id,
          name,
          desc,
          DateTime.parse(time.toString()),
        );
      }
    }
  }

  Future<void> remove(String name, String parent) async {
    try {
      NotificationService.flutterLocalNotificationsPlugin.cancel(
        name.hashCode,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        await listRef.child(parent).child('tasks').child(name).remove();
      }
    } catch (e, st) {
      GetIt.I.get<Talker>().handle(e, st);
    }
  }
}
