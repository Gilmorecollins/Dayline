import 'package:flutter/material.dart';

import '../../core/models/task.dart';
import '../../core/store/task_store.dart';
import 'dayline_calendar.dart';
import 'priority_selector.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskStore store;

  const AddTaskDialog({
    super.key,
    required this.store,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();

  DateTime _dueAt = DateTime.now();
  TaskPriority _priority = TaskPriority.medium;

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

  void _openDatePicker() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DaylineCalendar(
              selected: _dueAt,
              onSelected: (date) {
                setState(() => _dueAt = date);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
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
              // ===== HEADER =====
              const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              // ===== TASK TITLE =====
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  border: UnderlineInputBorder(),
                ),
                onSubmitted: (_) => _submit(),
              ),

              const SizedBox(height: 20),

              // ===== DATE + PRIORITY =====
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: _openDatePicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(_dueAt),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _priority.name,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== PRIORITY SELECTOR =====
              const Text(
                'Priority',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              PrioritySelector(
                selected: _priority,
                onChanged: (value) {
                  setState(() => _priority = value);
                },
              ),

              const SizedBox(height: 24),

              // ===== ACTIONS =====
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A6CF7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
