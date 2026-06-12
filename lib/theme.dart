import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _lightPrimary = Color(0xFF2E9E5E);
const Color _lightSecondary = Color(0xFF3BB768);
const Color _darkPrimary = Color(0xFF30E0A0);
const Color _darkBackground = Color(0xFF0D0D0D);
const Color _darkSurface = Color(0xFF1A1A1A);
const Color _lightBackground = Color(0xFFF5F7F6);

TextTheme _buildTextTheme(Brightness brightness) {
  final base = brightness == Brightness.dark
      ? ThemeData.dark().textTheme
      : ThemeData.light().textTheme;
  return GoogleFonts.poppinsTextTheme(base).copyWith(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: brightness == Brightness.dark
          ? const Color(0xFF81C784)
          : const Color(0xFF2E7D32),
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: brightness == Brightness.dark
          ? const Color(0xFF81C784)
          : const Color(0xFF2E7D32),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 15,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 13,
      height: 1.45,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
  );
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _lightPrimary,
    brightness: Brightness.light,
    primary: _lightPrimary,
    secondary: _lightSecondary,
    surface: Colors.white,
  ),
  scaffoldBackgroundColor: _lightBackground,
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: _lightBackground,
    foregroundColor: _lightPrimary,
    titleTextStyle: GoogleFonts.poppins(
      color: _lightPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _lightPrimary,
    labelColor: _lightPrimary,
    unselectedLabelColor: Colors.grey[600],
    dividerColor: Colors.transparent,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.black.withOpacity(0.06)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  textTheme: _buildTextTheme(Brightness.light),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _darkPrimary,
    brightness: Brightness.dark,
    background: _darkBackground,
    surface: _darkSurface,
    onSurface: Colors.white.withOpacity(0.92),
    primary: _darkPrimary,
    onPrimary: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: _darkBackground,
    foregroundColor: _darkPrimary,
    titleTextStyle: GoogleFonts.poppins(
      color: _darkPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: _darkPrimary,
    unselectedLabelColor: Colors.grey,
    indicatorColor: _darkPrimary,
    dividerColor: Colors.transparent,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: _darkSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.white.withOpacity(0.08)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  textTheme: _buildTextTheme(Brightness.dark),
);

TextStyle getSubtitleTextStyle(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: isDarkMode ? Colors.black : Colors.white,
  );
}
