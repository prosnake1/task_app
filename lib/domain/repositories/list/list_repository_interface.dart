import 'package:task_app/domain/repositories/list/models/list_task.dart';

abstract class AbstractListRepository {
  Future<List<ListTask>> listFetchData();
}
