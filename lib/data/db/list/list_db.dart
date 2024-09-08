import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/domain/list/model.dart';

final DatabaseReference databaseRef = FirebaseDatabase.instance
    .ref()
    .child('users')
    .child(FirebaseAuth.instance.currentUser!.uid)
    .child('lists');

Future<List<ListTask>> listFetchData() async {
  List<ListTask> listTaskList = [];
  try {
    DatabaseEvent event = await databaseRef.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        ListTask listTask = ListTask(
          name: value['name'],
        );
        listTaskList.add(listTask);
      });
    } else {
      GetIt.I<Talker>().debug('Data in Collection is Empty!');
    }
  } catch (error) {
    throw Error();
  }
  return listTaskList;
}
