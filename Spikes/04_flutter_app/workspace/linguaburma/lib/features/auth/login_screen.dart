import 'package:flutter/material.dart';
import 'package:linguaburma_app/core/services/google_sign_in_service.dart';
import 'package:linguaburma_app/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    bool success = await _googleSignInService.signIn();

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loader when signing in
            : ElevatedButton.icon(
                icon: Image.asset('assets/images/google_logo.png', height: 24),
                label: Text('Sign in with Google'),
                onPressed: _handleGoogleSignIn,
              ),
      ),
    );
  }
}
