import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:khayr_siyam/models/fasting_day.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final Function(CalendarFormat) onFormatChanged;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<FastingDay>> events;
  final DateTime? selectedDay;
  final String locale;

  const CalendarWidget({
    Key? key,
    required this.focusedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onFormatChanged,
    required this.calendarFormat,
    required this.events,
    required this.selectedDay,
    required this.locale,
  }) : super(key: key);

  List<FastingDay> _getEventsForDay(DateTime day) {
    return events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  IconData _getIconForFastingType(FastingDayType type) {
    switch (type) {
      case FastingDayType.mondayThursday:
        return Icons.calendar_today_outlined;
      case FastingDayType.whiteDays:
        return Icons.brightness_7_outlined;
      case FastingDayType.arafat:
      case FastingDayType.ashura:
      case FastingDayType.shawwal:
        return Icons.star_border_outlined;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Color(0xFF30E0A0) : Color(0xFF18805B);

    return TableCalendar<FastingDay>(
      locale: locale,
      firstDay: DateTime.utc(DateTime.now().year, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year + 200, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      onFormatChanged: onFormatChanged,
      eventLoader: _getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        formatButtonTextStyle: TextStyle(color: theme.colorScheme.primary),
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
      ),
      
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        markerDecoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isEmpty) return const SizedBox.shrink();
          final fastingDays = events.cast<FastingDay>();
          final isSelected = selectedDay != null && isSameDay(selectedDay, day);
          final iconColor = isSelected
              ? Colors.white
              : (Theme.of(context).brightness == Brightness.dark ? Color(0xFF30E0A0) : Color(0xFF18805B));
          return Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: fastingDays.map((fastingDay) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: Icon(
                  _getIconForFastingType(fastingDay.type),
                  size: 16,
                  color: iconColor,
                ),
              )).toList(),
            ),
          );
        },
      ),
    );
  }
}