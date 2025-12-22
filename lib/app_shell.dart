import 'package:flutter/material.dart';

import 'features/home/home_screen.dart';
import 'features/today/today_screen.dart';
import 'core/logic/demo_tasks.dart';
import 'core/logic/today_focus_engine.dart';

enum AppSection {
  home,
  myTasks,
  dayFocus,
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection _current = AppSection.home;

  @override
  Widget build(BuildContext context) {
    final tasks = demoTasks();
    final focus = TodayFocusEngine.build(tasks);

    Widget content;
    switch (_current) {
      case AppSection.home:
        content = const HomeScreen();
        break;
      case AppSection.myTasks:
        content = const Center(
          child: Text('My Tasks (coming soon)'),
        );
        break;
      case AppSection.dayFocus:
        content = TodayScreen(focus: focus);
        break;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Task creation comes Day 5
        },
        child: const Icon(Icons.add),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _current.index,
            onDestinationSelected: (index) {
              setState(() {
                _current = AppSection.values[index];
              });
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: const [
                  Icon(Icons.check_circle_outline, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Dayline',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list_alt_outlined),
                selectedIcon: Icon(Icons.list),
                label: Text('My Tasks'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.today_outlined),
                selectedIcon: Icon(Icons.today),
                label: Text('Day on Focus'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: content),
        ],
      ),
    );
  }
}
