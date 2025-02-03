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
        child: googleSignInService.currentUser == null
            // Show Sign In button if not signed in
            ? ElevatedButton(
                onPressed: () async {
                  bool success = await googleSignInService.signIn();
                  if (success) {
                    print("Signed in successfully!");
                  } else {
                    print("Sign-in failed.");
                  }
                },
                child: Text('Sign in with Google'),
              )
            // Show Sign Out button if already signed in
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Signed in as ${googleSignInService.currentUser?.displayName}'),
                  ElevatedButton(
                    onPressed: () async {
                      await googleSignInService.signOut();
                      print('Signed out successfully!');
                    },
                    child: Text('Sign out'),
                  ),
                ],
              ),
      ),
    );
  }
}
