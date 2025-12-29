import 'package:flutter/material.dart';
import 'core/store/task_store.dart';
import 'app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = TaskStore();
  await store.load();

  runApp(DaylineApp(store: store));
}

class DaylineApp extends StatelessWidget {
  final TaskStore store;

  const DaylineApp({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dayline',
          home: AppShell(store: store),
        );
      },
    );
  }
}
