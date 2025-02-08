import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GGSignIn extends StatefulWidget {
  const GGSignIn({super.key});

  @override
  State<GGSignIn> createState() => _GGSignInState();
}

class _GGSignInState extends State<GGSignIn> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user; 
  String? errorMessage; 

  void fnSignIn() async {
    try {
      var usr = await googleSignIn.signIn();
      if (usr != null) {
        setState(() {
          user = usr;
          errorMessage = null; // Clear any previous error messages
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Sign-in failed: $e"; // Update UI with the error message
      });
    }
  }

  void fnSignOut() async {
    await googleSignIn.signOut();
    setState(() {
      user = null; // Reset the user state on sign-out
      errorMessage = null; // Clear error message on sign-out
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign-In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user == null) ...[
              TextButton(
                onPressed: fnSignIn,
                child: const Text("Sign in using Google"),
              ),
            ] else ...[
              Text("Welcome, ${user!.displayName ?? 'User'}!"),
              const SizedBox(height: 10),
              TextButton(
                onPressed: fnSignOut,
                child: const Text("Sign Out"),
              ),
            ],
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}