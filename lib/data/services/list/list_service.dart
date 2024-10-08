import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/data/services/list/list_service_interface.dart';

class ListService implements AbstractListService {
  final DatabaseReference listRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('lists');
  @override
  Future<DataSnapshot> getLists() async {
    try {
      DatabaseEvent event = await listRef.once();
      DataSnapshot snapshot = event.snapshot;
      return snapshot;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> add(String name) async {
    try {
      String id = listRef.push().key.toString();
      if (FirebaseAuth.instance.currentUser != null) {
        await listRef.child(id).set(
          {
            'name': name,
            'id': id,
          },
        );
      } else {
        GetIt.I.get<Talker>().debug('User is empty!');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> remove(String id) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          await listRef.child(id).remove();
        }
      } else {
        GetIt.I.get<Talker>().debug('User is empty!');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
