// features/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:linguaburma_app/core/services/google_sign_in_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final googleSignInService = Provider.of<GoogleSignInService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await googleSignInService.signIn();
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}