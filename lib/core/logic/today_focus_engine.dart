import '../models/task.dart';
import 'priority_engine.dart';

class TodayFocus {
  final List<Task> urgent; // next 6 hours or overdue
  final List<Task> today;  // rest of today

  TodayFocus({
    required this.urgent,
    required this.today,
  });
}

class TodayFocusEngine {
  static TodayFocus build(List<Task> tasks) {
    final now = DateTime.now();

    final urgent = <Task>[];
    final today = <Task>[];

    for (final task in tasks) {
      if (task.status == TaskStatus.completed) continue;

      final updatedPriority = PriorityEngine.calculate(task);
      final hoursRemaining = task.deadline.difference(now).inHours;

      final isToday =
          task.deadline.year == now.year &&
          task.deadline.month == now.month &&
          task.deadline.day == now.day;

      if (hoursRemaining <= 6) {
        urgent.add(task);
      } else if (isToday) {
        today.add(task);
      }
    }

    urgent.sort((a, b) => a.deadline.compareTo(b.deadline));
    today.sort((a, b) => a.deadline.compareTo(b.deadline));

    return TodayFocus(
      urgent: urgent,
      today: today,
    );
  }
}
