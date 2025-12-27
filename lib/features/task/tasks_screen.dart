import 'package:flutter/material.dart';
import '../../core/store/task_store.dart';

class TasksScreen extends StatelessWidget {
  final TaskStore store;

  const TasksScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    if (store.tasks.isEmpty) {
      return const Center(
        child: Text('No tasks yet'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: store.tasks.length,
      itemBuilder: (_, index) {
        final task = store.tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.status.name),
        );
      },
    );
  }
}
