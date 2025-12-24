import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = [];

  // ─────────────────────────
  // CRUD
  // ─────────────────────────
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateStatus(String id, TaskStatus status) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;

    _tasks[index] = _tasks[index].copyWith(status: status);
    notifyListeners();
  }

  // ─────────────────────────
  // LIST GETTERS
  // ─────────────────────────
  List<Task> get allTasks => List.unmodifiable(_tasks);

  List<Task> get todayTaskList {
    final now = DateTime.now();
    return _tasks.where((task) {
      if (task.dueAt == null) return false;
      return task.dueAt!.year == now.year &&
          task.dueAt!.month == now.month &&
          task.dueAt!.day == now.day &&
          task.status != TaskStatus.completed;
    }).toList();
  }

  List<Task> get upcomingTaskList {
    final now = DateTime.now();
    return _tasks.where((task) {
      if (task.dueAt == null) return false;
      return task.dueAt!.isAfter(now) &&
          task.status != TaskStatus.completed;
    }).toList();
  }

  List<Task> get backlogTaskList {
    return _tasks
        .where((task) => task.status == TaskStatus.pending)
        .toList();
  }

  // ─────────────────────────
  // COUNT GETTERS (Dashboard)
  // ─────────────────────────
  int get totalTasks => _tasks.length;

  int get todayTasks => todayTaskList.length;

  int get upcomingTasks => upcomingTaskList.length;

  int get inProgressTasks =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  int get needsReviewTasks =>
      _tasks.where((t) => t.status == TaskStatus.needsReview).length;

  int get backlogTasks => backlogTaskList.length;
}
