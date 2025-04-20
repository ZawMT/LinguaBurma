import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lb_v1/providers/pv_userinfo.dart';
import 'package:provider/provider.dart';

import 'pg_landing.dart';

class PGSignIn extends StatefulWidget {
  const PGSignIn({super.key});

  @override
  State<PGSignIn> createState() => _PGSignInState();
}

class _PGSignInState extends State<PGSignIn> {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'openid'], serverClientId: "435659788182-a71jli1unj6rh6li9r85mjl9fifp9qe3.apps.googleusercontent.com");
  GoogleSignInAccount? user; 
  String? errorMessage; 

  void fnSignIn({
    required Function(String) onSuccess, // Callback for navigation
    }) async {
    try {
      await dotenv.load(fileName: ".env"); 
      String backendUrl = dotenv.env['BACKEND_URL'] ?? ""; /* No env value will cause error */ 
      var usr = await googleSignIn.signIn();
      if (usr != null) {
        final GoogleSignInAuthentication auth = await usr.authentication;
        final String idToken = auth.idToken!;  
        final response = await http.post(
          Uri.parse("$backendUrl/auth/social/google/"),
          body: jsonEncode({"access_token": idToken}),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          setState(() {
            user = usr;
            errorMessage = null; // Clear any previous error messages
          });

          // Call the success callback to handle navigation
          String? loginUsrName = user!.displayName;
          loginUsrName ??= user?.email;
          onSuccess.call(loginUsrName!);
        } else {
          setState(() {
            errorMessage = "Login failed: ${response.body}";
          });
        }
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
              ElevatedButton(
                onPressed: () {
                  fnSignIn(
                    onSuccess: (loginUserName) {
                      final authProvider = Provider.of<PVUserInfo>(context, listen: false);
                      authProvider.login(loginUserName);
                      // Navigate to the landing page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const PgLanding()),
                      );
                    },
                  );
                },
                child: const Text('Login with Google'),
              )  
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