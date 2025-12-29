import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = [];

  // =====================
  // Core accessors
  // =====================
  List<Task> get tasks => List.unmodifiable(_tasks);

  int get totalCount => _tasks.length;

  // =====================
  // Derived counters
  // =====================
  int get todayCount =>
      _tasks.where((t) => t.isToday).length;

  int get inProgressCount =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  int get needsReviewCount =>
      _tasks.where((t) => t.status == TaskStatus.needsReview).length;

  int get backlogCount =>
      _tasks.where((t) => t.isBacklog).length;

  // =====================
  // Mutations
  // =====================
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
}
