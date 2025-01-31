import 'package:flutter/material.dart';
import 'package:linguaburma_app/features/splash/splash_screen.dart';
import 'package:linguaburma_app/features/auth/login_screen.dart';
import 'package:linguaburma_app/features/home/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => SplashScreen(),
      login: (context) => LoginScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
