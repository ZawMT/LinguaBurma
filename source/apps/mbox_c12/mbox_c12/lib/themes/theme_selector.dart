import 'package:flutter/material.dart';
import 'package:mbox_c12/themes/themes.dart'; // Assuming this path is correct

class ThemeSelector with ChangeNotifier { // Use 'with' for mixin
  static final ThemeSelector _instance = ThemeSelector._internal(); // Singleton instance

  factory ThemeSelector() {
    return _instance;
  }

  ThemeSelector._internal(); // Private constructor

  ThemeData _currentTheme = AppTheme.themeBluish; // Default theme

  ThemeData get currentTheme => _currentTheme;

  void setTheme(String themeName) {
    ThemeData newTheme;
    switch (themeName) {
      case 'bluish':
        newTheme = AppTheme.themeBluish;
        break;
      case 'greenish':
        newTheme = AppTheme.themeGreenish;
        break;
      default:
        newTheme = AppTheme.themeBluish; // Default fallback
        break;
    }

    if (_currentTheme != newTheme) { // Only update if theme actually changes
      _currentTheme = newTheme;
      notifyListeners(); // Notify all listening widgets to rebuild
    }
  }
}