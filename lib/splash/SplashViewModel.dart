import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends ChangeNotifier {
  Future<String> decideStartScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('is_registered') ?? false;
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) return '/dashboard';
    if (isRegistered) return '/login';
    return '/signup';
  }
}
