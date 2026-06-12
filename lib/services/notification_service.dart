import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:khayr_siyam/services/preference_service.dart';
import 'package:khayr_siyam/services/hijri_date_service.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notifications.initialize(initializationSettings);
  }

  static Future<void> scheduleFastingReminder({
    required int id,
    required DateTime scheduledDate,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'fasting_reminders',
      'Rappels de jeûne',
      channelDescription: 'Notifications pour les jours de jeûne',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    print('[NotificationService] Tentative de planification d\'une notification :');
    print('  - id: '
        '[32m$id[0m');
    print('  - scheduledDate: '
        '\u001b[34m$scheduledDate\u001b[0m');
    print('  - titre: $title');
    print('  - body: $body');
    print('  - timezone locale: ${tz.local}');
    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      print('[NotificationService] Notification planifiée avec succès !');
    } on Exception catch (e) {
      print('[NotificationService] Erreur lors de la planification de la notification (zonedSchedule): '
          '\u001b[31m$e\u001b[0m');
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<bool> requestPermissions() async {
    print('[NotificationService] Demande des permissions de notifications...');
    
    // Vérifier et demander les permissions de notifications
    PermissionStatus notificationStatus = await Permission.notification.status;
    
    if (notificationStatus.isDenied) {
      print('[NotificationService] Permission de notification refusée, demande en cours...');
      notificationStatus = await Permission.notification.request();
    }
    
    if (notificationStatus.isPermanentlyDenied) {
      print('[NotificationService] Permission de notification refusée définitivement');
      return false;
    }
    
    // Vérifier les permissions d'alarme exacte sur Android
    bool canScheduleExactAlarms = await _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.canScheduleExactNotifications() ?? false;
    
    print('[NotificationService] Peut planifier des alarmes exactes: $canScheduleExactAlarms');
    
    if (!canScheduleExactAlarms) {
      print('[NotificationService] Impossible de planifier des alarmes exactes, ouverture des paramètres...');
      await openExactAlarmSettings();
      return false;
    }
    
    print('[NotificationService] Toutes les permissions sont accordées');
    return true;
  }

  static Future<void> scheduleAllNotifications() async {
    print('[NotificationService] Début de la planification des notifications...');
    
    // Vérifier les permissions d'abord
    bool hasPermissions = await requestPermissions();
    if (!hasPermissions) {
      print('[NotificationService] Permissions insuffisantes, arrêt de la planification');
      return;
    }
    
    // Charger les préférences utilisateur
    final notificationTime = await PreferenceService.getNotificationTime();
    final enabledNotifications = await PreferenceService.getEnabledNotifications();
    final notificationDays = await PreferenceService.getNotificationDays();
    final language = await PreferenceService.getLanguage();

    // Choisir la bonne localisation
    final localizations = lookupAppLocalizations(Locale(language));

    // Calculer les jours de jeûne à venir
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final allEvents = await HijriDateService().getFastingDaysForYear(now.year, language);
    final allDays = allEvents.values.expand((days) => days).toList();
    final upcoming = allDays.where((day) {
      final dayDate = DateTime(day.date.year, day.date.month, day.date.day);
      return dayDate.isAfter(today) || dayDate.isAtSameMomentAs(today);
    }).toList();

    // Annuler toutes les notifications existantes
    await cancelAllNotifications();

    int notifId = 0;
    int scheduledCount = 0;
    
    for (final fastingDay in upcoming) {
      // Vérifier si ce type de jeûne est activé dans les préférences
      final key = fastingDay.type.toString().split('.').last;
      if (!(enabledNotifications[key] ?? true)) continue;
      
      for (final daysBefore in notificationDays) {
        final scheduledDate = DateTime(
          fastingDay.date.year,
          fastingDay.date.month,
          fastingDay.date.day,
          notificationTime.hour,
          notificationTime.minute,
        ).subtract(Duration(days: daysBefore));
        
        if (scheduledDate.isAfter(DateTime.now())) {
          // Formatage de la date selon la locale
          final formattedDate = DateFormat.yMMMMEEEEd(language).format(fastingDay.date);
          final description = fastingDay.getDescription(localizations);
          final body = '$formattedDate — $description';
          await scheduleFastingReminder(
            id: notifId++,
            scheduledDate: scheduledDate,
            title: fastingDay.getTitle(localizations),
            body: body,
          );
          scheduledCount++;
        }
      }
    }
    
    print('[NotificationService] Planification terminée: $scheduledCount notifications planifiées');
  }

  static Future<void> openExactAlarmSettings() async {
    print('[NotificationService] Ouverture de la page de permission d\'alarmes exactes');
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
  }
  
  static Future<bool> checkNotificationPermissions() async {
    PermissionStatus notificationStatus = await Permission.notification.status;
    bool canScheduleExactAlarms = await _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.canScheduleExactNotifications() ?? false;
    
    return notificationStatus.isGranted && canScheduleExactAlarms;
  }
  
  static Future<void> sendTestNotification() async {
    print('[NotificationService] Envoi d\'une notification de test...');
    
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'fasting_reminders',
      'Rappels de jeûne',
      channelDescription: 'Notifications pour les jours de jeûne',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      await _notifications.show(
        999, // ID unique pour la notification de test
        'Test de notification',
        'Si vous voyez cette notification, le système fonctionne correctement !',
        platformChannelSpecifics,
      );
      print('[NotificationService] Notification de test envoyée avec succès !');
    } on Exception catch (e) {
      print('[NotificationService] Erreur lors de l\'envoi de la notification de test: '
          '\u001b[31m$e\u001b[0m');
    }
  }
} 