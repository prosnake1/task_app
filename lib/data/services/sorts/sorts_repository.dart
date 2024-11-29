import 'package:task_app/domain/repositories/task/models/task.dart';

class SortsRepository {
  List<Task> sort(String opt, List<Task> tasks) {
    switch (opt) {
      case 'relevance':
        tasks = SortsRepository().sortByRelevance(tasks);
      case 'name':
        tasks = SortsRepository().sortByName(tasks);
      case 'date':
        tasks = SortsRepository().sortByDate(tasks);
    }
    return tasks;
  }

  List<Task> sortByRelevance(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.name.length.compareTo(b.name.length),
    );
    sortByName(tasks);
    sortByDate(tasks);
    return tasks;
  }

  List<Task> sortByName(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    return tasks;
  }

  List<Task> sortByDate(List<Task> tasks) {
    tasks.sort(
      (a, b) {
        if (a.time.isNotEmpty && b.time.isNotEmpty) {
          DateTime now = DateTime.now();
          DateTime aDate = DateTime.parse(a.time);
          DateTime bDate = DateTime.parse(b.time);
          if (aDate.isBefore(now) && bDate.isBefore(now)) {
            return 0;
          } else if (aDate.isBefore(now)) {
            return 1;
          } else if (bDate.isBefore(now)) {
            return -1;
          } else {
            return aDate.compareTo(bDate);
          }
        } else {
          return -a.time.compareTo(b.time);
        }
      },
    );
    return tasks;
  }
}
