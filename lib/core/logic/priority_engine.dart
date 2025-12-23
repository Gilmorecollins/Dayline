import '../models/task.dart';

class PriorityEngine {
  /// Calculates an effective priority based on time remaining.
  /// This does NOT mutate the task.
  static TaskPriority calculate(Task task) {
    if (task.dueAt == null) {
      return task.priority;
    }

    final now = DateTime.now();
    final remaining = task.dueAt!.difference(now);

    // Overdue or within 6 hours → Critical
    if (remaining.inMinutes <= 360) {
      return TaskPriority.critical;
    }

    // Within 24 hours → High
    if (remaining.inHours <= 24) {
      return TaskPriority.high;
    }

    // Within 3 days → Medium
    if (remaining.inDays <= 3) {
      return TaskPriority.medium;
    }

    // Otherwise, keep assigned priority
    return task.priority;
  }
}
