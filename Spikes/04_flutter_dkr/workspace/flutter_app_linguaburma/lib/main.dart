import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'features/routes/app_routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.home,
    );
  }
}
