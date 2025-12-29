import 'package:flutter/material.dart';
import '../../core/store/task_store.dart';

class HomeScreen extends StatelessWidget {
  final TaskStore store;

  const HomeScreen({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _StatCard(
                label: 'Total Tasks',
                value: store.totalCount,
                icon: Icons.list_alt,
              ),
              _StatCard(
                label: 'Today',
                value: store.todayCount,
                icon: Icons.today,
              ),
              _StatCard(
                label: 'In Progress',
                value: store.inProgressCount,
                icon: Icons.timelapse,
              ),
              _StatCard(
                label: 'Needs Review',
                value: store.needsReviewCount,
                icon: Icons.rate_review,
              ),
              _StatCard(
                label: 'Backlogs',
                value: store.backlogCount,
                icon: Icons.warning_amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Color(0x11000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 12),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
