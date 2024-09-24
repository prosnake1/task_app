import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ListService {
  final DatabaseReference databaseRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('lists');
  Future<void> add(String name) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await databaseRef.child(name).set(
          {
            'name': name,
          },
        );
      } else {
        GetIt.I.get<Talker>().debug('User is empty!');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> remove(String name) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          await databaseRef.child(name).remove();
        }
      } else {
        GetIt.I.get<Talker>().debug('User is empty!');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
