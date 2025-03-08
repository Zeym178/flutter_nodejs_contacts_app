import 'package:contacts_app/themes/darkMode.dart';
import 'package:contacts_app/themes/lightMode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  final String _themeKey = "isdark";
  bool _isDark = false;

  bool get isDark => _isDark;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool(_themeKey) ?? false;
    if (isDark) {
      _themeData = darkMode;
      _isDark = true;
      prefs.setBool(_themeKey, true);
    } else {
      _themeData = lightMode;
      _isDark = false;
      prefs.setBool(_themeKey, false);
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isDark) {
      _themeData = lightMode;
      _isDark = false;
      prefs.setBool(_themeKey, false);
    } else {
      _themeData = darkMode;
      _isDark = true;
      prefs.setBool(_themeKey, true);
    }
    notifyListeners();
  }
}
