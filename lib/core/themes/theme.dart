import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  static const appBackgroundColor = Color.fromARGB(255, 5, 38, 8);
  static const buttonColors =  Color.fromARGB(255, 96, 225, 101);
  static const constantTextColor = Colors.black;
}

//Theme : Dark Mode
ThemeData darkMode = ThemeData(
  useMaterial3: true,
 colorScheme: const ColorScheme.dark(
    primary: Color(0xFF0A0A0A), // pure dark base
    secondary: Color(0xFF1A1A1A), // subtle contrast surface
    inversePrimary: Color(0xFFB0B0B0), // softer white text
    onPrimary: Colors.white, // readable text
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);




//Theme: Light Mode
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFFFAFAFA), //  try background
    secondary: const Color(0xFFF1F1F1), // subtle contrast
    inversePrimary: const Color(0xFF121212), // dark text for contrast
    onPrimary: Colors.black,
  
    // matching neon blue accent
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);




// Theme Notifier for persistent theme management
class ThemeNotifier extends Notifier<ThemeData> {
  static const String _themeKey = 'isDarkMode';

  @override
  ThemeData build() {
    // Load theme from shared preferences on initialization
    _loadTheme();
    return darkMode; // Default to dark mode
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? true; // Default to dark mode
    state = isDark ? darkMode : lightMode;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state == darkMode;
    final newTheme = isDark ? lightMode : darkMode;
    await prefs.setBool(_themeKey, !isDark);
    state = newTheme;
  }

  bool get isDarkMode => state == darkMode;
}

// NotifierProvider for theme
final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeData>(() {
  return ThemeNotifier();
});

// Provider to get isDarkMode boolean
final isThemeDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(themeNotifierProvider) == darkMode;
});


