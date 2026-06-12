import 'package:hijri/hijri_calendar.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';
import 'package:flutter/material.dart';

enum FastingDayType {
  mondayThursday,
  whiteDays,
  arafat,
  ashura,
  shawwal,
  dhulHijjahDay,
  ramadan,
  eidAlFitr,
  eidAlAdha,
  tashriqDay,
}

class FastingDay {
  final FastingDayType type;
  final DateTime date;
  late final HijriCalendar hijriDate;

  FastingDay({required this.type, required this.date}) {
    hijriDate = HijriCalendar.fromDate(date);
  }

  // Get the title of the fasting day based on locale
  String getTitle(AppLocalizations localizations) {
    switch (type) {
      case FastingDayType.mondayThursday:
        return localizations.mondayThursday;
      case FastingDayType.whiteDays:
        return localizations.whiteDays;
      case FastingDayType.arafat:
        return localizations.arafatDay;
      case FastingDayType.ashura:
        return localizations.ashuraDay;
      case FastingDayType.shawwal:
        return localizations.shawwalDays;
      case FastingDayType.dhulHijjahDay:
        return localizations.dhulHijjahDays;
      case FastingDayType.ramadan:
        return localizations.ramadan;
      case FastingDayType.eidAlFitr:
        return localizations.eidAlFitr;
      case FastingDayType.eidAlAdha:
        return localizations.eidAlAdha;
      case FastingDayType.tashriqDay:
        return localizations.tashriqDays;
    }
  }

  // Get the description of the fasting day based on locale
  String getDescription(AppLocalizations localizations) {
    switch (type) {
      case FastingDayType.mondayThursday:
        return localizations.mondayThursdayDescription;
      case FastingDayType.whiteDays:
        return localizations.whiteDaysDescription;
      case FastingDayType.arafat:
        return localizations.arafatDayDescription;
      case FastingDayType.ashura:
        return localizations.ashuraDayDescription;
      case FastingDayType.shawwal:
        return localizations.shawwalDaysDescription;
      case FastingDayType.dhulHijjahDay:
        return localizations.dhulHijjahDaysDescription;
      case FastingDayType.ramadan:
        return localizations.ramadanDescription;
      case FastingDayType.eidAlFitr:
        return localizations.eidAlFitrDescription;
      case FastingDayType.eidAlAdha:
        return localizations.eidAlAdhaDescription;
      case FastingDayType.tashriqDay:
        return localizations.tashriqDaysDescription;
    }
  }

  // Get the color for the fasting day type
  int getColor() {
    switch (type) {
      case FastingDayType.mondayThursday:
        return 0xFF4CAF50; // Green
      case FastingDayType.whiteDays:
        return 0xFF2196F3; // Blue
      case FastingDayType.arafat:
        return 0xFFFF9800; // Orange
      case FastingDayType.ashura:
        return 0xFF9C27B0; // Purple
      case FastingDayType.shawwal:
        return 0xFF00BCD4; // Cyan
      case FastingDayType.dhulHijjahDay:
        return 0xFFFF5722; // Deep Orange
      case FastingDayType.ramadan:
        return 0xFF3F51B5; // Indigo
      case FastingDayType.eidAlFitr:
        return 0xFFE91E63; // Pink
      case FastingDayType.eidAlAdha:
        return 0xFFE91E63; // Pink
      case FastingDayType.tashriqDay:
        return 0xFF795548; // Brown
    }
  }

  // Check if this is a forbidden fasting day
  bool get isForbidden {
    return type == FastingDayType.eidAlFitr ||
           type == FastingDayType.eidAlAdha ||
           type == FastingDayType.tashriqDay;
  }

  // Check if this is a recommended fasting day
  bool get isRecommended {
    return type == FastingDayType.mondayThursday ||
           type == FastingDayType.whiteDays ||
           type == FastingDayType.arafat ||
           type == FastingDayType.ashura ||
           type == FastingDayType.shawwal ||
           type == FastingDayType.dhulHijjahDay;
  }

  // Check if this is an obligatory fasting day
  bool get isObligatory {
    return type == FastingDayType.ramadan;
  }

  // Get the icon for the fasting day type
  IconData getIcon() {
    switch (type) {
      case FastingDayType.mondayThursday:
        return Icons.calendar_view_day;
      case FastingDayType.whiteDays:
        return Icons.brightness_7;
      case FastingDayType.arafat:
      case FastingDayType.ashura:
      case FastingDayType.shawwal:
      case FastingDayType.dhulHijjahDay:
        return Icons.star;
      case FastingDayType.ramadan:
        return Icons.nights_stay;
      case FastingDayType.eidAlFitr:
      case FastingDayType.eidAlAdha:
        return Icons.celebration;
      case FastingDayType.tashriqDay:
        return Icons.block;
    }
  }

  @override
  String toString() {
    return 'FastingDay{date: $date, hijriDate: ${hijriDate.hDay}/${hijriDate.hMonth}/${hijriDate.hYear}, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FastingDay &&
        other.date == date &&
        other.hijriDate.hDay == hijriDate.hDay &&
        other.hijriDate.hMonth == hijriDate.hMonth &&
        other.hijriDate.hYear == hijriDate.hYear &&
        other.type == type;
  }

  @override
  int get hashCode {
    return date.hashCode ^
           hijriDate.hDay.hashCode ^
           hijriDate.hMonth.hashCode ^
           hijriDate.hYear.hashCode ^
           type.hashCode;
  }
} 