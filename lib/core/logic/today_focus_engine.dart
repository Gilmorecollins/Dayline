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
    final urgent = tasks.where((t) {
      if (t.dueAt == null) return false;
      final now = DateTime.now();
      final diff = t.dueAt!.difference(now);
      return diff.inHours <= 6 && !t.isBacklog;
    }).toList();

    final today = tasks.where((t) => t.isToday && !urgent.contains(t)).toList();

    return TodayFocus(
      urgent: urgent,
      today: today,
    );
  }
}
