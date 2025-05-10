import 'package:flutter/material.dart';
import 'package:lb_v1/themes/themes.dart';

class ThemeSelector {
  static ThemeData _currentTheme = AppTheme.themeBluish; // Default theme

  static ThemeData get currentTheme => _currentTheme;

  static void setTheme(String themeName) {
    switch (themeName) {
      case 'bluish':
        _currentTheme = AppTheme.themeBluish;
        // TODO: To notify listeners here if you're using a state management solution
        break;

      case 'greenish':
        _currentTheme = AppTheme.themeGreenish;
        // TODO: Notify listeners
        break;

      default:
        _currentTheme = AppTheme.themeBluish; // Default fallback
        // TODO: Notify listeners
        break;
    }
  }
}