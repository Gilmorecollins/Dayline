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
    // ✅ use LIST getter, not count
    final List<Task> tasks = store.todayTaskList;

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

        return _TaskTile(
          task: task,
          onAdvance: () {
            store.updateStatus(
              task.id,
              _nextStatus(task.status),
            );
          },
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

class _TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onAdvance;

  const _TaskTile({
    required this.task,
    required this.onAdvance,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0x11000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _statusColor(task.status),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 15,
                color: isCompleted ? Colors.black38 : Colors.black87,
                decoration:
                    isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          if (!isCompleted)
            IconButton(
              tooltip: 'Advance status',
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: onAdvance,
            ),
        ],
      ),
    );
  }

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.needsReview:
        return Colors.orange;
      case TaskStatus.completed:
        return Colors.green;
    }
  }
}
