import 'package:flutter/material.dart';

import 'core/store/task_store.dart';
import 'features/home/home_screen.dart';
import 'features/today/today_screen.dart';

enum AppSection {
  dashboard,
  today,
  tasks,
}

class AppShell extends StatefulWidget {
  final TaskStore store;

  const AppShell({
    super.key,
    required this.store,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection _current = AppSection.dashboard;

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (_current) {
      case AppSection.dashboard:
        content = HomeScreen(store: widget.store);
        break;
      case AppSection.today:
        content = TodayScreen(store: widget.store);
        break;
      case AppSection.tasks:
        content = const Center(child: Text('Tasks (coming soon)'));
        break;
    }

    return Scaffold(
      body: Row(
        children: [
          _SideNav(
            current: _current,
            onSelect: (s) => setState(() => _current = s),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }
}

class _SideNav extends StatelessWidget {
  final AppSection current;
  final ValueChanged<AppSection> onSelect;

  const _SideNav({
    required this.current,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFFF7F8FA),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _NavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            active: current == AppSection.dashboard,
            onTap: () => onSelect(AppSection.dashboard),
          ),
          _NavItem(
            icon: Icons.today,
            label: "Today's Focus",
            active: current == AppSection.today,
            onTap: () => onSelect(AppSection.today),
          ),
          _NavItem(
            icon: Icons.list,
            label: 'Tasks',
            active: current == AppSection.tasks,
            onTap: () => onSelect(AppSection.tasks),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? Colors.blue : Colors.black54;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: active ? Colors.blue.withOpacity(0.08) : null,
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
