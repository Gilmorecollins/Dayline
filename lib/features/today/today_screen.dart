import 'package:flutter/material.dart';

import '../../core/logic/today_focus_engine.dart';
import '../../core/models/task.dart';

class TodayScreen extends StatelessWidget {
  final TodayFocus focus;

  const TodayScreen({
    super.key,
    required this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Today'),
        elevation: 0,
        backgroundColor: const Color(0xFFF7F8FA),
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (focus.urgent.isNotEmpty) ...[
            _sectionTitle('Urgent'),
            const SizedBox(height: 12),
            ...focus.urgent.map((t) => _TaskCard(task: t)),
            const SizedBox(height: 28),
          ],
          _sectionTitle('Today'),
          const SizedBox(height: 12),
          if (focus.today.isEmpty)
            const Text(
              'Nothing else scheduled.',
              style: TextStyle(color: Colors.black54),
            ),
          ...focus.today.map((t) => _TaskCard(task: t)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Due at ${task.deadline.hour.toString().padLeft(2, '0')}:'
            '${task.deadline.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
