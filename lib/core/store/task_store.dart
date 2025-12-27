import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = [];

  // --------------------------------------------------
  // Core access
  // --------------------------------------------------

  List<Task> get tasks => List.unmodifiable(_tasks);

  // 👇 REQUIRED by TodayScreen
  List<Task> get todayTasks =>
      _tasks.where((t) => t.isToday && !t.isCompleted).toList();

  // --------------------------------------------------
  // Counters (Dashboard)
  // --------------------------------------------------

  int get totalTasks => _tasks.length;

  int get todayCount => todayTasks.length;

  int get inProgressCount =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  int get needsReviewCount =>
      _tasks.where((t) => t.status == TaskStatus.needsReview).length;

  int get backlogCount =>
      _tasks.where((t) => t.isBacklog).length;

  // --------------------------------------------------
  // Mutations
  // --------------------------------------------------

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateStatus(String taskId, TaskStatus status) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(status: status);
    notifyListeners();
  }

  // --------------------------------------------------
  // Lifecycle (Phase 3 – placeholder)
  // --------------------------------------------------

  Future<void> load() async {
    // Persistence will be implemented next phase
    return;
  }
}
