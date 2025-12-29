import 'package:flutter/material.dart';
import 'core/store/task_store.dart';
import 'features/home/home_screen.dart';
import 'features/today/today_screen.dart';

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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (i) {
              setState(() => _index = i);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.today),
                label: Text("Today's Focus"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Tasks'),
              ),
            ],
          ),
          Expanded(child: _buildPage()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Dialog wiring returns in Phase 6B
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPage() {
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
