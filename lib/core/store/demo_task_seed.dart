import '../models/task.dart';
import 'task_store.dart';

Future<void> seedTaskStoreIfEmpty(TaskStore store) async {
  if (store.totalTasks > 0) return;

  store.addTask(
    Task(
      id: 'seed-1',
      title: 'Welcome to Dayline',
      createdAt: DateTime.now(),
      dueAt: DateTime.now().add(const Duration(hours: 2)),
      priority: TaskPriority.medium,
      status: TaskStatus.pending,
    ),
  );

  store.addTask(
    Task(
      id: 'seed-2',
      title: 'Add your first task',
      createdAt: DateTime.now(),
      dueAt: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.low,
      status: TaskStatus.pending,
    ),
  );
}
