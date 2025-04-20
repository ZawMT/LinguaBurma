import 'package:flutter/material.dart';

class PVUserInfo with ChangeNotifier {
  String? _username; 
  String? get username => _username; 

  void login(String username) {
    _username = username;
    notifyListeners(); 
  }

  void logout() {
    _username = null;
    notifyListeners(); 
  }
}