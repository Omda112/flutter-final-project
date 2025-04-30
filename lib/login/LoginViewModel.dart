import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  String? email, password;
  bool isLoading = false;

  void updateEmail(String value) => email = value;
  void updatePassword(String value) => password = value;

  Future<String?> login(BuildContext context) async {
    if (email == null || password == null) return 'Please enter email and password.';

    isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('user_email');
    String? savedPassword = prefs.getString('user_password');

    if (email == savedEmail && password == savedPassword) {
      await prefs.setBool('is_logged_in', true);
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/dashboard');
      return null;
    } else {
      isLoading = false;
      notifyListeners();
      return 'Incorrect email or password.';
    }
  }
}
