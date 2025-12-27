import '../models/task.dart';

class TodayFocus {
  final List<Task> urgent;
  final List<Task> today;

  TodayFocus({
    required this.urgent,
    required this.today,
  });
}

class TodayFocusEngine {
  static TodayFocus build(List<Task> tasks) {
    final now = DateTime.now();

    final urgent = tasks.where((task) {
      if (task.dueAt == null) return false;
      if (task.status == TaskStatus.completed) return false;

      final diff = task.dueAt!.difference(now);
      return diff.inHours <= 6 && diff.isNegative == false;
    }).toList();

    // 📅 Today = due today AND not already urgent AND not completed
    final today = tasks.where((task) {
      if (task.dueAt == null) return false;
      if (task.status == TaskStatus.completed) return false;
      if (urgent.contains(task)) return false;

      final due = task.dueAt!;
      return due.year == now.year &&
          due.month == now.month &&
          due.day == now.day;
    }).toList();

    return TodayFocus(
      urgent: urgent,
      today: today,
    );
  }
}
