import '../models/task.dart';
import 'task_store.dart';

TaskStore seedTaskStore() {
  final store = TaskStore();

  store.addTask(
    Task(
      id: '1',
      title: 'Submit report',
      createdAt: DateTime.now(),
      dueAt: DateTime.now().add(const Duration(hours: 2)),
      priority: TaskPriority.critical,
      status: TaskStatus.pending,
    ),
  );

  store.addTask(
    Task(
      id: '2',
      title: 'Prepare meeting notes',
      createdAt: DateTime.now(),
      dueAt: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
    ),
  );

  store.addTask(
    Task(
      id: '3',
      title: 'Review documents',
      createdAt: DateTime.now(),
      dueAt: DateTime.now().subtract(const Duration(days: 1)),
      priority: TaskPriority.medium,
      status: TaskStatus.pending,
    ),
  );

  return store;
}
