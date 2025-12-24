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
    return SizedBox(
      width: 320,
      height: 360, // ✅ FIXED HEIGHT — prevents overflow
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          _buildWeekdays(),
          const SizedBox(height: 8),
          Expanded(child: _buildGrid()), // ✅ Scroll-safe area
          const SizedBox(height: 8),
          _buildShortcuts(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
    );
  }

  Widget _buildWeekdays() {
    const labels = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels
          .map(
            (d) => SizedBox(
              width: 40,
              child: Text(
                d,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGrid() {
    final firstDay =
        DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final daysInMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;

    final startOffset = firstDay.weekday % 7;
    final totalCells = startOffset + daysInMonth;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: totalCells,
      itemBuilder: (_, index) {
        if (index < startOffset) return const SizedBox.shrink();

        final day = index - startOffset + 1;
        final date =
            DateTime(_visibleMonth.year, _visibleMonth.month, day);

        final isSelected =
            date.year == widget.selected.year &&
            date.month == widget.selected.month &&
            date.day == widget.selected.day;

        final isPast = date.isBefore(
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day),
        );

        return GestureDetector(
          onTap: isPast ? null : () => widget.onSelected(date),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? accentColor : null,
              borderRadius: BorderRadius.circular(8),
            ),
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
      },
    );
  }

  Widget _buildShortcuts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _shortcut('Today', DateTime.now()),
        _shortcut('Tomorrow', DateTime.now().add(const Duration(days: 1))),
        _shortcut('Next week', DateTime.now().add(const Duration(days: 7))),
      ],
    );
  }

  Widget _shortcut(String label, DateTime date) {
    return TextButton(
      onPressed: () => widget.onSelected(date),
      child: Text(label),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
