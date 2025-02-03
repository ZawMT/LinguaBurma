import 'package:flutter/material.dart';
import 'package:linguaburma_app/themes/app_theme.dart';
import 'package:linguaburma_app/routes/app_routes.dart';
import 'package:linguaburma_app/core/app/app_constants.dart';
import 'package:linguaburma_app/core/services/google_sign_in_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleSignInService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: AppConstants.appTitle,
      theme: appTheme,
      initialRoute: AppRoutes.splash, // Start from SplashScreen
      routes: AppRoutes.getRoutes(),
    );
  }
}
