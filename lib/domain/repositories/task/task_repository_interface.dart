import 'package:task_app/domain/repositories/task/models/task.dart';

abstract class AbstractTaskRepository {
  Future<List<Task>> fetchTaskData(String name);
}
