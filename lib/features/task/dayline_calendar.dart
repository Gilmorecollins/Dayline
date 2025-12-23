import 'package:flutter/material.dart';

class DaylineCalendar extends StatefulWidget {
  final DateTime selected;
  final ValueChanged<DateTime> onSelected;

  const DaylineCalendar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<DaylineCalendar> createState() => _DaylineCalendarState();
}

class _DaylineCalendarState extends State<DaylineCalendar> {
  late DateTime _visibleMonth;

  static const Color accentColor = Color(0xFF4A6CF7);

  @override
  void initState() {
    super.initState();
    _visibleMonth = DateTime(widget.selected.year, widget.selected.month);
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildDays();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // ===== HEADER =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _visibleMonth =
                        DateTime(_visibleMonth.year, _visibleMonth.month - 1);
                  });
                },
              ),
              Text(
                '${_monthName(_visibleMonth.month)} ${_visibleMonth.year}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _visibleMonth =
                        DateTime(_visibleMonth.year, _visibleMonth.month + 1);
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ===== WEEKDAYS =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              'SU','MO','TU','WE','TH','FR','SA'
            ].map((d) => Text(
              d,
              style: TextStyle(fontSize: 11, color: Colors.black54),
            )).toList(),
          ),

          const SizedBox(height: 8),

          // ===== GRID =====
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: days,
          ),

          const SizedBox(height: 12),

          // ===== SHORTCUTS =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Shortcut('Today', DateTime.now()),
              _Shortcut('Tomorrow', DateTime.now().add(const Duration(days: 1))),
              _Shortcut('Next week', DateTime.now().add(const Duration(days: 7))),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDays() {
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final daysInMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;

    final startOffset = firstDay.weekday % 7;
    final totalCells = startOffset + daysInMonth;

    return List.generate(totalCells, (index) {
      if (index < startOffset) return const SizedBox.shrink();

      final day = index - startOffset + 1;
      final date = DateTime(_visibleMonth.year, _visibleMonth.month, day);

      final isSelected =
          date.year == widget.selected.year &&
          date.month == widget.selected.month &&
          date.day == widget.selected.day;

      final isPast = date.isBefore(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      );

      return GestureDetector(
        onTap: isPast
            ? null
            : () {
                widget.onSelected(date);
              },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? accentColor : null,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isPast
                      ? Colors.black26
                      : Colors.black87,
            ),
          ),
        ),
      );
    });
  }

  String _monthName(int month) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return months[month - 1];
  }

  Widget _Shortcut(String label, DateTime date) {
    return TextButton(
      onPressed: () => widget.onSelected(date),
      child: Text(label),
    );
  }
}
