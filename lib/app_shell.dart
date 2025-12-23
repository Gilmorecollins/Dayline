import 'package:flutter/material.dart';

import 'features/home/home_screen.dart';
import 'features/today/today_screen.dart';

import 'core/store/task_store.dart';
import 'core/store/demo_task_seed.dart';
import 'core/logic/today_focus_engine.dart';

enum AppSection {
  dashboard,
  todaysFocus,
  tasks,
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection _current = AppSection.dashboard;

  late final TaskStore _store;

  static const Color accentColor = Color(0xFF4A6CF7);
  static const Color sideNavBg = Color(0xFFF3F4F6);

  @override
  void initState() {
    super.initState();
    _store = seedTaskStore();
  }

  @override
  Widget build(BuildContext context) {
    final focus = TodayFocusEngine.build(_store.allTasks);

    Widget content;
    switch (_current) {
      case AppSection.dashboard:
        content = HomeScreen(store: _store);
        break;
      case AppSection.todaysFocus:
       content = TodayScreen(store: _store);

        break;
      case AppSection.tasks:
        content = const Center(
          child: Text('Tasks (coming soon)'),
        );
        break;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () {
          // Task creation comes next phase
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Row(
        children: [
          // ===== SIDEBAR =====
          Container(
            width: 220,
            color: sideNavBg,
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Logo
                const Icon(Icons.check_circle_outline, size: 32),
                const SizedBox(height: 8),
                const Text(
                  'Dayline',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 32),

                _SideNavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  selected: _current == AppSection.dashboard,
                  onTap: () =>
                      setState(() => _current = AppSection.dashboard),
                ),
                _SideNavItem(
                  icon: Icons.today_outlined,
                  label: "Today's Focus",
                  selected: _current == AppSection.todaysFocus,
                  onTap: () =>
                      setState(() => _current = AppSection.todaysFocus),
                ),
                _SideNavItem(
                  icon: Icons.list_alt_outlined,
                  label: 'Tasks',
                  selected: _current == AppSection.tasks,
                  onTap: () =>
                      setState(() => _current = AppSection.tasks),
                ),
              ],
            ),
          ),

          // ===== MAIN CONTENT =====
          Expanded(child: content),
        ],
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SideNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFF4A6CF7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: selected ? accentColor.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: selected ? accentColor : Colors.black54,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: selected ? accentColor : Colors.black87,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
