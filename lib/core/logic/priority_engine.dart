import '../models/task.dart';

class PriorityEngine {
  static TaskPriority calculate(Task task) {
    final now = DateTime.now();
    final remaining = task.deadline.difference(now);

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

    // Otherwise, keep original priority
    return task.originalPriority;
  }
}
