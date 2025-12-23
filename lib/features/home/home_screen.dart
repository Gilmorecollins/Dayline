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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7F8FA),
        foregroundColor: Colors.black87,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: 280,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search anything',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _SummaryCard(
              label: 'Total Tasks',
              value: store.totalTasks.toString(),
              icon: Icons.list_alt,
            ),
            _SummaryCard(
              label: 'Today',
              value: store.todayTasks.toString(),
              icon: Icons.today,
            ),
            _SummaryCard(
              label: 'Upcoming',
              value: store.upcomingTasks.toString(),
              icon: Icons.schedule,
            ),
            _SummaryCard(
              label: 'In Progress',
              value: store.inProgressTasks.toString(),
              icon: Icons.timelapse,
            ),
            _SummaryCard(
              label: 'Needs Review',
              value: store.needsReviewTasks.toString(),
              icon: Icons.rate_review,
            ),
            _SummaryCard(
              label: 'Backlogs',
              value: store.backlogTasks.toString(),
              icon: Icons.warning_amber_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
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
