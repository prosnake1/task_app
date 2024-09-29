import 'package:firebase_database/firebase_database.dart';

abstract class AbstractListService {
  Future<DataSnapshot> getLists();
  Future<void> add(String name);
  Future<void> remove(String name);
}
