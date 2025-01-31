import 'package:flutter/material.dart';
import 'package:linguaburma_app/core/services/auth_service.dart';
import 'package:linguaburma_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await AuthService.isLoggedIn();
    await Future.delayed(Duration(seconds: 2)); // Show splash for 2 seconds
    if (mounted) {
      Navigator.pushReplacementNamed(context, isLoggedIn ? AppRoutes.home : AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100), // Your app logo
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
