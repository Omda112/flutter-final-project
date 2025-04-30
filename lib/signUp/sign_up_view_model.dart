import 'package:firstproject/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends ChangeNotifier {
  String? name, email, password;
  bool isLoading = false;

  void updateName(String value) => name = value;
  void updateEmail(String value) => email = value;
  void updatePassword(String value) => password = value;

  Future<void> signUp(BuildContext context) async {
    if (name == null || email == null || password == null) return;

    isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name!);
    await prefs.setString('user_email', email!);
    await prefs.setString('user_password', password!);
    await prefs.setBool('is_registered', true);
    await prefs.setBool('is_logged_in', true);

    isLoading = false;
    notifyListeners();

    Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
