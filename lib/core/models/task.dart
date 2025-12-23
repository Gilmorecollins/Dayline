enum TaskStatus {
  pending,
  inProgress,
  needsReview,
  completed,
}

enum TaskPriority {
  critical,
  high,
  medium,
  low,
}

class Task {
  final String id;
  final String title;
  final String? description;

  final DateTime createdAt;
  final DateTime? dueAt;

  TaskStatus status;
  TaskPriority priority;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.dueAt,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.medium,
  });

  /// A task is overdue (Backlog) if:
  /// - It has a due date
  /// - It is NOT completed
  /// - Due date is in the past
  bool get isBacklog {
    if (dueAt == null) return false;
    if (status == TaskStatus.completed) return false;
    return dueAt!.isBefore(DateTime.now());
  }

  /// A task belongs to "Today"
  bool get isToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year &&
        dueAt!.month == now.month &&
        dueAt!.day == now.day;
  }

  /// A task is upcoming if due in the future (excluding today)
  bool get isUpcoming {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.isAfter(
      DateTime(now.year, now.month, now.day, 23, 59),
    );
  }
}
