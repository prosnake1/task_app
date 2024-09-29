import 'package:task_app/data/services/list/list_service_interface.dart';
import 'package:task_app/domain/repositories/list/list_repository_interface.dart';
import 'package:task_app/domain/repositories/list/models/list_task.dart';
import 'package:task_app/internal/di_container.dart';

class ListRepository implements AbstractListRepository {
  ListRepository(this.listService);
  final AbstractListService listService;
  @override
  Future<List<ListTask>> getLists() async {
    try {
      final snapshot = await listService.getLists();
      if (snapshot.value != null) {
        final values = snapshot.value as Map<dynamic, dynamic>;
        talker.debug(values);
        final lists = values.entries
            .map(
              (e) => ListTask.fromJson(Map<String, dynamic>.from(e.value)),
            )
            .toList();
        return lists;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
