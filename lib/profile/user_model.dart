import 'dart:io';
import 'package:firstproject/profile/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UserModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  User? _user;
  User? get user => _user;

  // Load user data from SharedPreferences including image path
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('user_name');
    String? email = prefs.getString('user_email');
    String? imagePath = prefs.getString('user_image_path');

    File? imageFile;
    if (imagePath != null && File(imagePath).existsSync()) {
      imageFile = File(imagePath);
    }

    if (name != null && email != null) {
      _user = User(name: name, bio: email, image: imageFile);
      notifyListeners();
    }
  }

  // Select and save image to internal app storage
  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = basename(image.path);
      final savedImage = await File(image.path).copy('${directory.path}/$fileName');

      _user?.image = savedImage;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_image_path', savedImage.path);

      notifyListeners();
    }
  }

  // Remove image and clear path from SharedPreferences
  Future<void> removeImage() async {
    _user?.image = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_image_path');
    notifyListeners();
  }

  // Update and persist user name
  Future<void> updateName(String newName) async {
    if (_user != null) {
      _user!.name = newName;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', newName);
      notifyListeners();
    }
  }

  // Update and persist user email
  Future<void> updateEmail(String newEmail) async {
    if (_user != null) {
      _user!.bio = newEmail;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', newEmail);
      notifyListeners();
    }
  }

  // Logout and clear login status
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    Navigator.pushReplacementNamed(context, '/login');
  }
}
