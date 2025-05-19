import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_model.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  // Load user data from SharedPreferences
  // Future<void> loadUserData() async {
  //   _user = await UserModel.fromPrefs();
  //   notifyListeners();
  // }
  Future<void> loadUserData() async {
    _user = await UserModel.fromPrefs();

    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString('user_image_path');
      if (imagePath != null && imagePath.isNotEmpty) {
        _user!.image = File(imagePath);
      }
    }

    notifyListeners();
  }


  // Sign up new user
  Future<void> signUp(String name, String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    _user = UserModel(name: name, email: email, password: password);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_registered', true);
    await prefs.setBool('is_logged_in', true);

    isLoading = false;
    notifyListeners();

    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  // Login user
  Future<String?> login(String? email, String? password, BuildContext context) async {
    if (email == null || email.isEmpty || password == null || password.isEmpty) {
      return 'Please enter email and password.';
    }

    isLoading = true;
    notifyListeners();

    final savedUser = await UserModel.fromPrefs();

    if (savedUser != null &&
        savedUser.email == email.trim() &&
        savedUser.password == password.trim()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      _user = savedUser;
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

  // Logout user
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    await prefs.remove('user_image_path');    // <--- ADD THIS LINE
    _user = null;
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = basename(image.path);
      final savedImage = await File(image.path).copy('${dir.path}/$fileName');
      _user?.image = savedImage;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_image_path', savedImage.path);
      notifyListeners();
    }
  }

  // Remove profile image
  Future<void> removeImage() async {
    _user?.image = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_image_path');
    notifyListeners();
  }

  // Update name
  Future<void> updateName(String name) async {
    if (_user == null) return;
    _user!.name = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    notifyListeners();
  }

  // Update email
  Future<void> updateEmail(String email) async {
    if (_user == null) return;
    _user!.email = email;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    notifyListeners();
  }

  Future<void> updatePassword(String password) async {
    if (_user == null) return;

    _user!.password = password;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_password', password);
    notifyListeners();
  }

}
