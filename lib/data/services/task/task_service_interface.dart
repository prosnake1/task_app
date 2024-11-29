import 'package:firebase_database/firebase_database.dart';

abstract class AbstractTaskService {
  Future<void> add(String name, String desc, String? time, String parent);
  Future<void> remove(String name, String parent);
  Future<DataSnapshot> getTasks(String listId, String? id);
}
