import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PGSignIn extends StatefulWidget {
  const PGSignIn({super.key});

  @override
  State<PGSignIn> createState() => _PGSignInState();
}

class _PGSignInState extends State<PGSignIn> {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'openid'], serverClientId: "435659788182-a71jli1unj6rh6li9r85mjl9fifp9qe3.apps.googleusercontent.com");
  GoogleSignInAccount? user; 
  String? errorMessage; 

  void fnSignIn() async {
    try {
      print("*********1 Loading ENV file");
      await dotenv.load(fileName: ".env"); 
      String backendUrl = dotenv.env['BACKEND_URL'] ?? ""; /* No env value will cause error */ 
      print("*********2 Backend URL: $backendUrl");
      print("*********3 Calling google sign-in");
      var usr = await googleSignIn.signIn();
      print("*********4 Signin attempt done");
      if (usr != null) {
        print("*********5 User info after log in is OK");
        final GoogleSignInAuthentication auth = await usr.authentication;
        print("*********5.1 Done authentication");
        print("*********5.1 auth value $auth");
        final String idToken = auth.idToken!;  
        print("Token: $idToken");
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
        } else {
          setState(() {
            errorMessage = "Login failed: ${response.body}";
          });
        }
      }else {
        print("*********6 User info after log in is NULL");
      }
    } catch (e) {
      print("*********7 Sing-in failed: $e");
      setState(() {
        errorMessage = "Sign-in failed: $e"; // Update UI with the error message
      });
    }
  }
  

/*
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
*/
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