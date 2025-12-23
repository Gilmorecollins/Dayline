import 'package:flutter/material.dart';
import '../../core/models/task.dart';


class PrioritySelector extends StatelessWidget {
  final TaskPriority selected;
  final ValueChanged<TaskPriority> onChanged;

  const PrioritySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: TaskPriority.values.map((priority) {
        final isSelected = priority == selected;
        final color = _colorFor(priority);

        return GestureDetector(
          onTap: () => onChanged(priority),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
              border: Border.all(
                color: isSelected ? color : Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    priority.name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check, size: 18),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _colorFor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.critical:
        return Colors.red;
      case TaskPriority.high:
        return Colors.orange;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.low:
        return Colors.grey;
    }
  }
}
