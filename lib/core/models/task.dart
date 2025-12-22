enum TaskPriority {
  critical,
  high,
  medium,
  low,
}

enum TaskStatus {
  pending,
  completed,
}

class Task {
  final String id;
  final String title;
  final DateTime deadline;
  final TaskPriority priority;
  final TaskPriority originalPriority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? lastEscalatedAt;

  Task({
    required this.id,
    required this.title,
    required this.deadline,
    required this.priority,
    required this.originalPriority,
    this.status = TaskStatus.pending,
    DateTime? createdAt,
    this.lastEscalatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isOverdue => DateTime.now().isAfter(deadline);

  Duration get timeRemaining => deadline.difference(DateTime.now());
}
