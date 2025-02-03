import 'package:google_sign_in/google_sign_in.dart';
import 'package:linguaburma_app/core/api/api_service.dart';
import 'package:linguaburma_app/core/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class GoogleSignInService with ChangeNotifier {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "850772198427-tq3nfr1n1ku5l028nhb55jd5f9jni8lj.apps.googleusercontent.com", // Use Web Client ID from Firebase
    scopes: ['email', 'profile']
  );

  final ApiService _apiService = ApiService();

  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentUser => _currentUser;

  // Sign in using Google and authenticate with backend
  Future<bool> signIn() async {
    try {
      // Request Google sign-in
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return false; // User cancelled sign-in

      // Set current user
      _currentUser = account;

      // Fetch authentication details
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) return false; // No idToken received

      // Send idToken to the backend for validation and obtain JWT token
      final response = await _apiService.googleLogin(idToken);

      if (response != null && response['token'] != null) {
        String jwtToken = response['token']; // Get secure token from backend
        await AuthService.saveToken(jwtToken); // Store securely in storage
        notifyListeners(); // Notify listeners (UI will rebuild)
        print('Login successful');
        return true;
      }

      print('Login failed');
      return false;
    } catch (error) {
      print('Error during Google Sign-In: $error');
      return false;
    }
  }

  // Sign out from Google and clear session
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google
      _currentUser = null; // Clear the current user
      await AuthService.logout(); // Secure logout (clear session/token)
      notifyListeners(); // Notify listeners (UI will rebuild)
      print('Signed out successfully');
    } catch (error) {
      print('Error during sign out: $error');
    }
  }
}
