import 'package:flutter/material.dart';
import '/features/home/home_screen.dart';
import '/core/app/app_constants.dart';

class AppRoutes {
  static const String home = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(title: AppConstants.homePageTitle),
    };
  }
}