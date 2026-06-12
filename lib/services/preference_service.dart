import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PreferenceService {
  static late SharedPreferences _prefs;

  static const String _languageKey = 'language_code';
  static const String _themeKey = 'theme';
  static const String _notificationTimeKey = 'notificationTime';
  static const String _enabledNotificationsKey = 'enabledNotifications';
  static const String _notificationDaysKey = 'notification_days';
  static const String _fastedDaysKey = 'fasted_days';

  static const String defaultLanguage = 'fr';
  static const bool defaultTheme = false; // false for light, true for dark

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString(_languageKey, language);
  }

  static Future<String> getLanguage() async {
    return _prefs.getString(_languageKey) ?? defaultLanguage;
  }

  static Future<void> setTheme(bool isDark) async {
    await _prefs.setBool(_themeKey, isDark);
  }

  static Future<bool> getTheme() async {
    return _prefs.getBool(_themeKey) ?? defaultTheme;
  }

  static Future<void> setNotificationTime(TimeOfDay time) async {
    await _prefs.setInt('hour', time.hour);
    await _prefs.setInt('minute', time.minute);
  }

  static Future<TimeOfDay> getNotificationTime() async {
    final hour = _prefs.getInt('hour') ?? 20;
    final minute = _prefs.getInt('minute') ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static Future<void> updateNotificationPreference(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<Map<String, bool>> getEnabledNotifications() async {
    final keys = _prefs.getKeys().where((key) => key.startsWith('notif_'));
    final map = <String, bool>{};
    for (final key in keys) {
      map[key] = _prefs.getBool(key) ?? true;
    }
    return map;
  }
  
  static Future<void> setNotificationDays(List<int> days) async {
    final stringDays = days.map((d) => d.toString()).toList();
    await _prefs.setStringList(_notificationDaysKey, stringDays);
  }

  static Future<void> saveFastedDays(Set<DateTime> days) async {
    final prefs = await SharedPreferences.getInstance();
    final dateStrings = days.map((d) => d.toIso8601String()).toList();
    await prefs.setStringList(_fastedDaysKey, dateStrings);
  }

  static Future<Set<DateTime>> getFastedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStrings = prefs.getStringList(_fastedDaysKey) ?? [];
    return dateStrings.map(DateTime.parse).toSet();
  }

  static Future<List<int>> getNotificationDays() async {
    // This handles the case where an old value might be stored as an int
    try {
      final List<String>? stringDays = _prefs.getStringList(_notificationDaysKey);
      if (stringDays == null || stringDays.isEmpty) {
        // If no value, try to read an old int value for migration
        final int? oldDays = _prefs.getInt(_notificationDaysKey);
        if (oldDays != null) {
          await _prefs.remove(_notificationDaysKey); // remove old key
          await setNotificationDays([oldDays]); // set new list value
          return [oldDays];
        }
        return [1]; // Default to 1 day if nothing is found
      }
      return stringDays.map((d) => int.parse(d)).toList();
    } catch (e) {
      // If any other error occurs, reset to default
      await _prefs.remove(_notificationDaysKey);
      await setNotificationDays([1]);
      return [1];
    }
  }

  static Future<void> resetToDefaults() async {
    await _prefs.clear();
  }
} 