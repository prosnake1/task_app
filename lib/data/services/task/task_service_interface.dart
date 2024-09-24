abstract class AbstractTaskService {
  Future<void> add(String name, String desc, String? time, String parent);
  Future<void> remove(String name, String parent);
}
