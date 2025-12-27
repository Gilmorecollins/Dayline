import 'package:flutter/material.dart';

import 'core/store/task_store.dart';
import 'core/store/demo_task_seed.dart';
import 'app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = TaskStore();
  await store.load();
  await seedTaskStoreIfEmpty(store);

  runApp(DaylineApp(store: store));
}

class DaylineApp extends StatelessWidget {
  final TaskStore store;

  const DaylineApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dayline',
      debugShowCheckedModeBanner: false,
      home: AppShell(store: store),
    );
  }
}
