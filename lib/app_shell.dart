import 'package:flutter/material.dart';

import 'core/store/task_store.dart';
import 'features/home/home_screen.dart';
import 'features/today/today_screen.dart';

class AppShell extends StatefulWidget {
  final TaskStore store;

  const AppShell({super.key, required this.store});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FB),

      // ───────────────── AppBar ─────────────────
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Row(
          children: const [
            SizedBox(width: 12),
            Icon(Icons.check_circle_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Dayline',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Search (coming soon)',
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Settings (coming soon)',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ───────────────── Body ─────────────────
      body: Row(
        children: [
          _SideNav(
            index: _index,
            onChanged: (i) => setState(() => _index = i),
          ),
          Expanded(child: _buildContent()),
        ],
      ),

      // ───────────────── Add Task FAB ─────────────────
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          // Hook dialog later (Phase 4)
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_index) {
      case 0:
        return HomeScreen(store: widget.store);
      case 1:
        return TodayScreen(store: widget.store);
      case 2:
        return const Center(child: Text('Tasks (coming soon)'));
      default:
        return const SizedBox.shrink();
    }
  }
}

// ───────────────── Side Navigation ─────────────────

class _SideNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const _SideNav({
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0x11000000)),
        ),
      ),
      child: Column(
        children: [
          _NavItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            selected: index == 0,
            onTap: () => onChanged(0),
          ),
          _NavItem(
            icon: Icons.today_outlined,
            label: "Today's Focus",
            selected: index == 1,
            onTap: () => onChanged(1),
          ),
          _NavItem(
            icon: Icons.list_alt_outlined,
            label: 'Tasks',
            selected: index == 2,
            onTap: () => onChanged(2),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F1FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? Colors.blue : Colors.black54,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
