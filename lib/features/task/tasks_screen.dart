import 'package:flutter/material.dart';

import '../../core/models/task.dart';
import '../../core/store/task_store.dart';
import '../../ui/ui_constants.dart';

class TasksScreen extends StatefulWidget {
  final TaskStore store;

  const TasksScreen({super.key, required this.store});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final tasks = widget.store.tasks.where((task) {
      if (_query.isEmpty) return true;
      return task.title.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    if (tasks.isEmpty) {
      return const _EmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SearchBar(
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: UI.s24),
        Expanded(
          child: ListView(
            children: [
              _Section('Pending', TaskStatus.pending, tasks),
              _Section('In Progress', TaskStatus.inProgress, tasks),
              _Section('Needs Review', TaskStatus.needsReview, tasks),
              _Section('Completed', TaskStatus.completed, tasks),
            ],
          ),
        ),
      ],
    );
  }
}

/* ───────────────── Search ───────────────── */

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search tasks',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: UI.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UI.r12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/* ───────────────── Section ───────────────── */

class _Section extends StatelessWidget {
  final String title;
  final TaskStatus status;
  final List<Task> all;

  const _Section(this.title, this.status, this.all);

  @override
  Widget build(BuildContext context) {
    final tasks = all.where((t) => t.status == status).toList();
    if (tasks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: UI.s24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: UI.section),
          const SizedBox(height: UI.s12),
          ...tasks.map((t) => _TaskTile(task: t)),
        ],
      ),
    );
  }
}

/* ───────────────── Task Tile ───────────────── */

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final completed = task.status == TaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: UI.s12),
      padding: const EdgeInsets.all(UI.s16),
      decoration: BoxDecoration(
        color: UI.surface,
        borderRadius: BorderRadius.circular(UI.r12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
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
          const SizedBox(width: UI.s12),
          Expanded(
            child: Text(
              task.title,
              style: UI.body.copyWith(
                decoration:
                    completed ? TextDecoration.lineThrough : null,
                color:
                    completed ? Colors.black38 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(TaskStatus s) {
    switch (s) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return UI.primary;
      case TaskStatus.needsReview:
        return Colors.orange;
      case TaskStatus.completed:
        return Colors.green;
    }
  }
}

/* ───────────────── Empty State ───────────────── */

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No tasks yet.\nAdd one to get started.',
        textAlign: TextAlign.center,
        style: UI.mutedText,
      ),
    );
  }
}
