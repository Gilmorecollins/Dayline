import 'package:flutter/material.dart';

import '../../core/models/task.dart';
import '../../core/store/task_store.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskStore store;

  const AddTaskDialog({super.key, required this.store});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  DateTime? _dueAt;
  TaskPriority _priority = TaskPriority.medium;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _dueAt = picked);
    }
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
      dueAt: _dueAt,
      priority: _priority,
      status: TaskStatus.pending,
    );

    widget.store.addTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // ───── Title ─────
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // ───── Controls ─────
              Row(
                children: [
                  _DateChip(
                    date: _dueAt,
                    onTap: _pickDate,
                  ),
                  const SizedBox(width: 12),
                  _PriorityChip(
                    value: _priority,
                    onChanged: (p) => setState(() => _priority = p),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ───── Actions ─────
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ───────────────── Date Chip ───────────────── */

class _DateChip extends StatelessWidget {
  final DateTime? date;
  final VoidCallback onTap;

  const _DateChip({this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.calendar_today, size: 16),
      label: Text(
        date == null
            ? 'Due date'
            : '${date!.day}/${date!.month}/${date!.year}',
      ),
      onPressed: onTap,
    );
  }
}

/* ───────────────── Priority Chip ───────────────── */

class _PriorityChip extends StatelessWidget {
  final TaskPriority value;
  final ValueChanged<TaskPriority> onChanged;

  const _PriorityChip({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TaskPriority>(
      tooltip: 'Priority',
      onSelected: onChanged,
      itemBuilder: (_) => TaskPriority.values
          .map(
            (p) => PopupMenuItem(
              value: p,
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _color(p),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(p.name),
                ],
              ),
            ),
          )
          .toList(),
      child: Chip(
        avatar: Icon(Icons.flag, size: 16, color: _color(value)),
        label: Text(value.name),
      ),
    );
  }

  Color _color(TaskPriority p) {
    switch (p) {
      case TaskPriority.critical:
        return Colors.red;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.low:
        return Colors.grey;
    }
  }
}
