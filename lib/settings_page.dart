import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:khayr_siyam/services/preference_service.dart';
import 'package:khayr_siyam/services/notification_service.dart';
import 'package:khayr_siyam/theme.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final Function(Locale) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  late Locale _currentLocale;
  late TimeOfDay _notificationTime;
  late Map<String, bool> _enabledNotifications;
  late List<int> _notificationDays;
  bool _isLoading = true;
  bool _hasNotificationPermissions = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _initializeNotifications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rafraîchir l'état des permissions quand on revient sur la page
    _refreshPermissions();
  }

  Future<void> _initializeNotifications() async {
    // Vérifier les permissions actuelles
    _hasNotificationPermissions = await NotificationService.checkNotificationPermissions();
    
    // Request notification permissions
    bool permissionsGranted = await NotificationService.requestPermissions();
    setState(() {
      _hasNotificationPermissions = permissionsGranted;
    });
    
    // Schedule notifications only if permissions are granted
    if (permissionsGranted) {
      await NotificationService.scheduleAllNotifications();
    }
  }

  Future<void> _loadPreferences() async {
    final isDark = await PreferenceService.getTheme();
    final languageCode = await PreferenceService.getLanguage();
    _notificationTime = await PreferenceService.getNotificationTime();
    _enabledNotifications = await PreferenceService.getEnabledNotifications();
    _notificationDays = await PreferenceService.getNotificationDays();
    
    setState(() {
      _isDarkMode = isDark;
      _currentLocale = Locale(languageCode);
      _isLoading = false;
    });
  }

  Future<void> _updateNotificationTime(TimeOfDay time) async {
    await PreferenceService.setNotificationTime(time);
    setState(() {
      _notificationTime = time;
    });
    // Reschedule notifications only if permissions are granted
    if (_hasNotificationPermissions) {
      await NotificationService.scheduleAllNotifications();
    }
  }

  Future<void> _updateNotificationPreference(String key, bool value) async {
    await PreferenceService.updateNotificationPreference(key, value);
    setState(() {
      _enabledNotifications[key] = value;
    });
    // Reschedule notifications only if permissions are granted
    if (_hasNotificationPermissions) {
      await NotificationService.scheduleAllNotifications();
    }
  }

  Future<void> _updateNotificationDays(int day) async {
    final newDays = List<int>.from(_notificationDays);
    if (newDays.contains(day)) {
      if (newDays.length > 1) { // Prevent removing the last one
        newDays.remove(day);
      }
    } else {
      newDays.add(day);
    }
    await PreferenceService.setNotificationDays(newDays);
    setState(() {
      _notificationDays = newDays;
    });
    // Reschedule notifications only if permissions are granted
    if (_hasNotificationPermissions) {
      await NotificationService.scheduleAllNotifications();
    }
  }

  void _onLanguageChanged(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
    PreferenceService.setLanguage(locale.languageCode);
    widget.onLanguageChanged(locale);
  }

  void _onThemeChanged(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
    PreferenceService.setTheme(isDark);
    widget.onThemeChanged(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _refreshPermissions() async {
    bool hasPermissions = await NotificationService.checkNotificationPermissions();
    if (hasPermissions != _hasNotificationPermissions) {
      setState(() {
        _hasNotificationPermissions = hasPermissions;
      });
      if (hasPermissions) {
        await NotificationService.scheduleAllNotifications();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimationLimiter(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildSectionHeader(theme, Icons.language, localizations.language),
            _buildLanguageSelector(theme),
            const SizedBox(height: 24),
            _buildSectionHeader(theme, Icons.palette, localizations.theme),
            _buildThemeSelector(theme),
            const SizedBox(height: 24),
            _buildSectionHeader(theme, Icons.notifications, localizations.notifications),
            _buildNotificationPermissionsCard(theme),
            const SizedBox(height: 16),
            _buildNotificationTimeSelector(theme),
            const SizedBox(height: 16),
            _buildNotificationDaysCard(theme),
            const SizedBox(height: 16),
            _buildNotificationTypesList(theme),
            const SizedBox(height: 32),
            _buildResetButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageOption(theme, 'English', const Locale('en')),
            const Divider(),
            _buildLanguageOption(theme, 'Français', const Locale('fr')),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(ThemeData theme, String name, Locale locale) {
    return RadioListTile<Locale>(
      title: Text(name, style: theme.textTheme.bodyLarge),
      value: locale,
      groupValue: _currentLocale,
      activeColor: theme.colorScheme.primary,
      onChanged: (newLocale) {
        if (newLocale != null) {
          _onLanguageChanged(newLocale);
        }
      },
    );
  }

  Widget _buildThemeSelector(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isDarkMode ? AppLocalizations.of(context)!.darkMode : AppLocalizations.of(context)!.lightMode,
              style: theme.textTheme.bodyLarge,
            ),
            Switch(
              value: _isDarkMode,
              activeColor: theme.colorScheme.primary,
              onChanged: _onThemeChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationPermissionsCard(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _hasNotificationPermissions ? Icons.check_circle : Icons.warning,
                  color: _hasNotificationPermissions ? Colors.green : Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _hasNotificationPermissions 
                        ? 'Permissions accordées' 
                        : 'Permissions requises',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _hasNotificationPermissions ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _hasNotificationPermissions
                  ? 'Les notifications de jeûne sont activées et fonctionnelles.'
                  : 'Pour recevoir les notifications de jeûne, veuillez accorder les permissions nécessaires.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
            if (!_hasNotificationPermissions) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        bool granted = await NotificationService.requestPermissions();
                        setState(() {
                          _hasNotificationPermissions = granted;
                        });
                        if (granted) {
                          await NotificationService.scheduleAllNotifications();
                        }
                      },
                      icon: const Icon(Icons.notifications),
                      label: const Text('Demander les permissions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await NotificationService.openExactAlarmSettings();
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text('Paramètres'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        side: BorderSide(color: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await NotificationService.sendTestNotification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notification de test envoyée !'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Tester les notifications'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTimeSelector(ThemeData theme) {
    // Format for display
    final formattedTime = _notificationTime.format(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: _notificationTime,
          );
          
          if (picked != null) {
            _updateNotificationTime(picked);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.notificationTime,
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      AppLocalizations.of(context)!.notificationTimeDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedTime,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationDaysCard(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.notificationDaysTitle,
              style: theme.textTheme.titleMedium
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.notificationDaysSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [1, 2, 3].map((day) => _buildDayOption(theme, day)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayOption(ThemeData theme, int day) {
    final isSelected = _notificationDays.contains(day);
    return GestureDetector(
      onTap: () => _updateNotificationDays(day),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Text(
          day.toString(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTypesList(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.notificationTypesTitle,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildNotificationTypeSwitch(
              theme,
              'mondayThursday',
              Icons.calendar_today,
              AppLocalizations.of(context)!.mondayThursday,
              _enabledNotifications['mondayThursday'] ?? true,
            ),
            const Divider(),
            _buildNotificationTypeSwitch(
              theme,
              'whiteDays',
              Icons.brightness_7,
              AppLocalizations.of(context)!.whiteDays,
              _enabledNotifications['whiteDays'] ?? true,
            ),
            const Divider(),
            _buildNotificationTypeSwitch(
              theme,
              'arafatDay',
              Icons.terrain,
              AppLocalizations.of(context)!.arafatDay,
              _enabledNotifications['arafatDay'] ?? true,
            ),
            const Divider(),
            _buildNotificationTypeSwitch(
              theme,
              'ashuraDay',
              Icons.history_edu,
              AppLocalizations.of(context)!.ashuraDay,
              _enabledNotifications['ashuraDay'] ?? true,
            ),
            const Divider(),
            _buildNotificationTypeSwitch(
              theme,
              'shawwalDays',
              Icons.filter_6,
              AppLocalizations.of(context)!.shawwalDays,
              _enabledNotifications['shawwalDays'] ?? true,
            ),
            const Divider(),
            _buildNotificationTypeSwitch(
              theme,
              'dhulHijjahDays',
              Icons.filter_9,
              AppLocalizations.of(context)!.dhulHijjahDays,
              _enabledNotifications['dhulHijjahDays'] ?? true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTypeSwitch(
    ThemeData theme,
    String key,
    IconData icon,
    String title,
    bool value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Switch(
            value: value,
            activeColor: theme.colorScheme.primary,
            onChanged: (newValue) {
              _updateNotificationPreference(key, newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResetButton(ThemeData theme) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          _showResetConfirmationDialog(theme);
        },
        icon: Icon(
          Icons.restore,
          color: theme.colorScheme.error,
        ),
        label: Text(
          AppLocalizations.of(context)!.resetSettings,
          style: TextStyle(color: theme.colorScheme.error),
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.resetConfirmationTitle),
        content: Text(AppLocalizations.of(context)!.resetConfirmationMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await PreferenceService.resetToDefaults();
              await _loadPreferences();
              
              final isDark = await PreferenceService.getTheme();
              _onThemeChanged(isDark);
            },
            child: Text(
              AppLocalizations.of(context)!.reset,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}