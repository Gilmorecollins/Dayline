import 'dart:collection';
import '../models/task.dart';

class TaskStore {
  final List<Task> _tasks = [];

  // ===== Lifecycle =====
  Future<void> load() async {
    // Phase 2: no persistence yet
    // Phase 3 will hydrate from disk
    return;
  }

  // ===== Core CRUD =====
  void addTask(Task task) {
    _tasks.add(task);
  }

  void updateStatus(String id, TaskStatus status) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(status: status);
  }

  // ===== Read-only views =====
  UnmodifiableListView<Task> get allTasks =>
      UnmodifiableListView(_tasks);

  // ===== Counters (USED BY UI) =====
  int get totalTasks => _tasks.length;

  int get todayCount =>
      _tasks.where((t) => t.isToday).length;

  int get inProgressCount =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  int get needsReviewCount =>
      _tasks.where((t) => t.status == TaskStatus.needsReview).length;

  int get backlogCount =>
      _tasks.where((t) => t.isBacklog).length;

  // ===== Lists =====
  List<Task> get todayTasks =>
      _tasks.where((t) => t.isToday).toList();

  bool get isEmpty => _tasks.isEmpty;
}
