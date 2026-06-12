import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'widgets/glass_card.dart';

import 'calendar_widget.dart';
import 'fasting_detail_page.dart';
import 'models/fasting_day.dart';
import 'services/hijri_date_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final HijriDateService _hijriDateService;
  Map<DateTime, List<FastingDay>> _events = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isLoading = true;
  bool _isDataLoaded = false;
  HijriDate? _hijriDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _hijriDateService = HijriDateService();
    _selectedDay = _focusedDay;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _loadEvents();
    }
  }

  Future<void> _loadEvents() async {
    final locale = AppLocalizations.of(context)!.localeName;
    try {
      final events = await _hijriDateService.getFastingDaysForYear(DateTime.now().year, locale);
      if (mounted) {
        setState(() {
          _events = events;
          _isLoading = false;
          _isDataLoaded = true;
          _updateHijriDate(_focusedDay, locale);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isDataLoaded = true;
        });
      }
    }
  }

  void _updateHijriDate(DateTime day, String locale) {
    setState(() {
      _hijriDate = HijriDateService.fromGregorian(day, locale);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!mounted) return;
    final locale = AppLocalizations.of(context)!.localeName;
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _updateHijriDate(selectedDay, locale);
    });

    final dayOnly = DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day);
    final eventsForDay = _events[dayOnly];

    if (eventsForDay != null && eventsForDay.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          final localizations = AppLocalizations.of(context)!;
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.event, color: theme.brightness == Brightness.dark ? Color(0xFF30E0A0) : Color(0xFF18805B)),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.yMMMMd(localizations.localeName).format(selectedDay),
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: eventsForDay.map((fastingDay) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForFastingType(fastingDay.type),
                            color: theme.brightness == Brightness.dark ? Color(0xFF30E0A0) : Color(0xFF18805B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            fastingDay.getTitle(localizations),
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.brightness == Brightness.dark ? Color(0xFF30E0A0) : Color(0xFF18805B),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: Text(localizations.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHeader(theme, localizations),
          const SizedBox(height: 16),
          _buildHijriDateCard(theme, localizations),
          const SizedBox(height: 8),
          _buildCalendar(localizations),
          const SizedBox(height: 16),
          _buildLegend(theme, localizations),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localizations.calendarTitle,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildHijriDateCard(ThemeData theme, AppLocalizations localizations) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, color: theme.brightness == Brightness.dark ? Colors.white : Colors.black),
          const SizedBox(width: 12),
          if (_hijriDate != null)
            Text(
              _hijriDate!.toFormat('d MMMM yyyy'),
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendar(AppLocalizations localizations) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CalendarWidget(
          focusedDay: _focusedDay,
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            if (mounted) {
              final locale = AppLocalizations.of(context)!.localeName;
              setState(() {
                _focusedDay = focusedDay;
                _updateHijriDate(focusedDay, locale);
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          calendarFormat: _calendarFormat,
          events: _events,
          selectedDay: _selectedDay,
          locale: localizations.localeName,
        ),
      ),
    );
  }

  Widget _buildLegend(ThemeData theme, AppLocalizations localizations) {
    return GlassCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.legend,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.brightness == Brightness.dark ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 16),
          _buildLegendItem(theme, _getIconForFastingType(FastingDayType.mondayThursday), localizations.legendMondayThursday),
          const SizedBox(height: 8),
          _buildLegendItem(theme, _getIconForFastingType(FastingDayType.whiteDays), localizations.legendWhiteDays),
          const SizedBox(height: 8),
          _buildLegendItem(theme, _getIconForFastingType(FastingDayType.ashura), localizations.legendSpecialDays),
        ],
      ),
    );
  }

  Widget _buildLegendItem(ThemeData theme, IconData icon, String text) {
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Color(0xFF30E0A0) : Color(0xFF18805B);
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      ],
    );
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
}