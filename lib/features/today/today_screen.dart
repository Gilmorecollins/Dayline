import 'package:flutter/material.dart';
import '../../core/store/task_store.dart';
import '../../core/logic/today_focus_engine.dart';
import '../../core/models/task.dart';

class TodayScreen extends StatelessWidget {
  final TaskStore store;

  const TodayScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final focus = TodayFocusEngine.build(store.allTasks);

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            title: const Text("Today's Focus"),
            elevation: 0,
            backgroundColor: const Color(0xFFF7F8FA),
            foregroundColor: Colors.black87,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (focus.urgent.isNotEmpty) ...[
                const Text(
                  'Urgent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...focus.urgent.map((task) => _TaskTile(
                      task: task,
                      store: store,
                    )),
                const SizedBox(height: 24),
              ],

              if (focus.today.isNotEmpty) ...[
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...focus.today.map((task) => _TaskTile(
                      task: task,
                      store: store,
                    )),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  final TaskStore store;


  const _TaskTile({
    required this.task,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          IconButton(
            tooltip: 'Mark completed',
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              store.updateStatus(task.id, TaskStatus.completed);
            },
          ),
        ],
      ),
    );
  }
}
