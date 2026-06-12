import 'package:flutter/foundation.dart';
import 'package:hijri/hijri_calendar.dart';
import '../models/fasting_day.dart';

class HijriDate {
  final HijriCalendar _calendar;

  HijriDate._(this._calendar);

  String toFormat(String format) {
    return _calendar.toFormat(format);
  }
}

class HijriDateService {
  static void setHijriLocale(String locale) {
    // La bibliothèque ne supporte que 'ar' et 'en' (par défaut)
    if (locale == 'ar') {
      HijriCalendar.setLocal(locale);
    } else {
      HijriCalendar.setLocal('en');
    }
  }

  static HijriDate fromGregorian(DateTime gregorianDate, String locale) {
    setHijriLocale(locale);
    return HijriDate._(HijriCalendar.fromDate(gregorianDate));
  }

  Future<Map<DateTime, List<FastingDay>>> getFastingDaysForYear(int year, String locale) {
    return compute(_getFastingDaysForYearIsolate, {'year': year, 'locale': locale});
  }

  static bool isMondayOrThursday(DateTime date) {
    return date.weekday == DateTime.monday || date.weekday == DateTime.thursday;
  }

  static bool isWhiteDay(HijriCalendar date) {
    return date.hDay == 13 || date.hDay == 14 || date.hDay == 15;
  }

  static bool isArafatDay(HijriCalendar date) {
    return date.hMonth == 12 && date.hDay == 9;
  }

  static bool isAshuraDay(HijriCalendar date) {
    return date.hMonth == 1 && date.hDay == 10;
  }

  static bool isShawwalDay(HijriCalendar date) {
    return date.hMonth == 10;
  }

  static bool isDhulHijjahDay(HijriCalendar date) {
    return date.hMonth == 12 && date.hDay >= 1 && date.hDay <= 9;
  }
}

Future<Map<DateTime, List<FastingDay>>> _getFastingDaysForYearIsolate(Map<String, dynamic> params) async {
  final int year = params['year']!;
  final String locale = params['locale']!;
  
  HijriDateService.setHijriLocale(locale);
  final Map<DateTime, List<FastingDay>> events = {};
  final gregorianStartDate = DateTime(year, 1, 1);
  final gregorianEndDate = DateTime(year, 12, 31);

  for (var day = gregorianStartDate;
      day.isBefore(gregorianEndDate.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
    final hijriDate = HijriCalendar.fromDate(day);
    final fastingTypes = _getFastingTypesForDayIsolate(day, hijriDate);

    if (fastingTypes.isNotEmpty) {
      final dayOnly = DateTime.utc(day.year, day.month, day.day);
      if (events[dayOnly] == null) {
        events[dayOnly] = [];
      }
      for (var type in fastingTypes) {
        events[dayOnly]!.add(FastingDay(date: day, type: type));
      }
    }
  }
  return events;
}

List<FastingDayType> _getFastingTypesForDayIsolate(DateTime gregorianDate, HijriCalendar hijriDate) {
  List<FastingDayType> types = [];

  if (gregorianDate.weekday == DateTime.monday || gregorianDate.weekday == DateTime.thursday) {
    types.add(FastingDayType.mondayThursday);
  }
  if (hijriDate.hDay == 13 || hijriDate.hDay == 14 || hijriDate.hDay == 15) {
    types.add(FastingDayType.whiteDays);
  }
  if (hijriDate.hMonth == 12 && hijriDate.hDay == 9) {
    types.add(FastingDayType.arafat);
  }
  if (hijriDate.hMonth == 1 && hijriDate.hDay == 10) {
    types.add(FastingDayType.ashura);
  }
  
  return types;
} 