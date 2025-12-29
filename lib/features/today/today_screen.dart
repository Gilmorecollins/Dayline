import 'package:flutter/material.dart';
import '../../core/models/task.dart';
import '../../core/store/task_store.dart';

class TodayScreen extends StatelessWidget {
  final TaskStore store;

  const TodayScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = store.todayTasks;

    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'No tasks for today 🎉',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        final task = tasks[index];

        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.priority.name),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              store.updateStatus(
                task.id,
                _nextStatus(task.status),
              );
            },
          ),
        );
      },
    );
  }

  TaskStatus _nextStatus(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return TaskStatus.inProgress;
      case TaskStatus.inProgress:
        return TaskStatus.needsReview;
      case TaskStatus.needsReview:
        return TaskStatus.completed;
      case TaskStatus.completed:
        return TaskStatus.completed;
    }
  }
}
