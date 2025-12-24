enum TaskStatus {
  pending,
  inProgress,
  needsReview,
  completed,
}

enum TaskPriority {
  low,
  medium,
  high,
  critical,
}

class Task {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? dueAt;
  final TaskPriority priority;
  final TaskStatus status;

  const Task({
    required this.id,
    required this.title,
    required this.createdAt,
    this.dueAt,
    required this.priority,
    required this.status,
  });

  // ✅ REQUIRED for immutable updates
  Task copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? dueAt,
    TaskPriority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      dueAt: dueAt ?? this.dueAt,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}
