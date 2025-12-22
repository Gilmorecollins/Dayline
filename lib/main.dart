import 'package:flutter/material.dart';
import 'app_shell.dart';

void main() {
  runApp(const DaylineApp());
}

class DaylineApp extends StatelessWidget {
  const DaylineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dayline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const AppShell(),
    );
  }
}
