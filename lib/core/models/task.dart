enum TaskPriority { critical, high, medium, low }
enum TaskStatus { pending, inProgress, needsReview, completed }

class Task {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? dueAt;
  final TaskPriority priority;
  final TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.createdAt,
    this.dueAt,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
  });

  // ----------------------------
  // Derived state (FIXES isCompleted error)
  // ----------------------------
  bool get isCompleted => status == TaskStatus.completed;

  bool get isToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year &&
        dueAt!.month == now.month &&
        dueAt!.day == now.day;
  }

  bool get isBacklog =>
      dueAt != null && dueAt!.isBefore(DateTime.now());

  // ----------------------------
  // Copy
  // ----------------------------
  Task copyWith({
    String? title,
    DateTime? dueAt,
    TaskPriority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      createdAt: createdAt,
      dueAt: dueAt ?? this.dueAt,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  // ----------------------------
  // Serialization
  // ----------------------------
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      dueAt:
          json['dueAt'] != null ? DateTime.parse(json['dueAt']) : null,
      priority: TaskPriority.values[json['priority']],
      status: TaskStatus.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'dueAt': dueAt?.toIso8601String(),
      'priority': priority.index,
      'status': status.index,
    };
  }
}
