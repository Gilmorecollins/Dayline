import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = [];

  // ---------- Mutations ----------
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(String taskId) {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }

  void updateStatus(String taskId, TaskStatus status) {
    final task = _tasks.firstWhere((t) => t.id == taskId);
    task.status = status;
    notifyListeners();
  }

  // ---------- Raw access ----------
  List<Task> get allTasks => List.unmodifiable(_tasks);

  // ---------- Derived counts ----------
  int get totalTasks => _tasks.length;

  int get todayTasks =>
      _tasks.where((t) => t.isToday && !t.isBacklog).length;

  int get upcomingTasks =>
      _tasks.where((t) => t.isUpcoming && !t.isBacklog).length;

  int get inProgressTasks =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;

  int get needsReviewTasks =>
      _tasks.where((t) => t.status == TaskStatus.needsReview).length;

  int get completedTasks =>
      _tasks.where((t) => t.status == TaskStatus.completed).length;

  int get backlogTasks =>
      _tasks.where((t) => t.isBacklog).length;
}
