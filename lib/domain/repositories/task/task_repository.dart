import 'package:task_app/data/services/task/task_service_interface.dart';
import 'package:task_app/domain/repositories/task/models/task.dart';
import 'package:task_app/domain/repositories/task/task_repository_interface.dart';
import 'package:task_app/internal/di_container.dart';

class TaskRepository implements AbstractTaskRepository {
  TaskRepository(this.taskService);
  final AbstractTaskService taskService;

  @override
  Future<List<Task>> getTasks(String id) async {
    try {
      final snapshot = await taskService.getTasks(id);
      if (snapshot.value != null) {
        final values = snapshot.value as Map<dynamic, dynamic>;
        talker.debug(values);
        final taskList = values.entries
            .map(
              (e) => Task.fromJson(Map<String, dynamic>.from(e.value)),
            )
            .toList();
        return taskList;
      } else {
        talker.debug('Data in Collection is Empty!');
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
