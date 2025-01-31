import 'package:google_sign_in/google_sign_in.dart';
import 'package:linguaburma_app/core/api/api_service.dart';
import 'package:linguaburma_app/core/services/auth_service.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  
  final ApiService _apiService = ApiService();

  Future<bool> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return false;

      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) return false;

      final response = await _apiService.googleLogin(idToken);

      if (response != null && response['token'] != null) {
        String jwtToken = response['token']; // Get secure token from backend
        await AuthService.saveToken(jwtToken); // Store securely
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

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await AuthService.logout(); // Secure logout
      print('Signed out successfully');
    } catch (error) {
      print('Error during sign out: $error');
    }
  }
}
