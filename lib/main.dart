import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';
import 'package:khayr_siyam/home_page.dart';
import 'package:khayr_siyam/services/hijri_date_service.dart';
import 'package:khayr_siyam/services/notification_service.dart';
import 'package:khayr_siyam/services/preference_service.dart';
import 'package:khayr_siyam/splash_screen.dart';
import 'package:khayr_siyam/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  await PreferenceService.init();
  await NotificationService.initialize();
  final language = await PreferenceService.getLanguage();
  await initializeDateFormatting(language);
  HijriDateService.setHijriLocale(language);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D0D),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: true,
  ));

  runApp(KhayrSiyamApp(initialLocale: language));
}

class KhayrSiyamApp extends StatefulWidget {
  final String initialLocale;
  const KhayrSiyamApp({Key? key, required this.initialLocale}) : super(key: key);

  @override
  State<KhayrSiyamApp> createState() => _KhayrSiyamAppState();
}

class _KhayrSiyamAppState extends State<KhayrSiyamApp> {
  late ThemeMode _themeMode;
  late Locale _locale;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.initialLocale);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDarkMode = await PreferenceService.getTheme();
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _isLoading = false;
    });
    _applySystemUi(isDarkMode);
  }

  void _applySystemUi(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF5F7F6),
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarContrastEnforced: true,
    ));
  }

  void _updateTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
    PreferenceService.setTheme(themeMode == ThemeMode.dark);
    _applySystemUi(themeMode == ThemeMode.dark);
  }

  void _changeLanguage(Locale locale) async {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await initializeDateFormatting(locale.languageCode, null);
      HijriDateService.setHijriLocale(locale.languageCode);
      await PreferenceService.setLanguage(locale.languageCode);

      setState(() {
        _locale = locale;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeMode,
        home: const Scaffold(
          backgroundColor: Color(0xFF121212),
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      title: 'Khayr Siyam',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SplashScreen(
        child: HomePage(
          onThemeChanged: _updateTheme,
          onLanguageChanged: _changeLanguage,
        ),
      ),
    );
  }
}
