import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String prefKey = "isDarkMode";

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(prefKey) ?? false;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _isDarkMode = isOn;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, _isDarkMode);
    notifyListeners();
  }
}
