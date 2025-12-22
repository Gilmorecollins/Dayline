import '../models/task.dart';

List<Task> demoTasks() {
  final now = DateTime.now();

  return [
    Task(
      id: '1',
      title: 'Submit report',
      deadline: now.add(const Duration(hours: 2)),
      priority: TaskPriority.low,
      originalPriority: TaskPriority.low,
    ),
    Task(
      id: '2',
      title: 'Prepare meeting notes',
      deadline: now.add(const Duration(hours: 10)),
      priority: TaskPriority.medium,
      originalPriority: TaskPriority.medium,
    ),
    Task(
      id: '3',
      title: 'Plan next week',
      deadline: now.add(const Duration(days: 2)),
      priority: TaskPriority.low,
      originalPriority: TaskPriority.low,
    ),
  ];
}
