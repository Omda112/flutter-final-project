import 'dart:io';
import 'package:firstproject/profile/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();
  User? _user;
  User? get user => _user;

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('user_name');
    String? email = prefs.getString('user_email');

    if (name != null && email != null) {
      _user = User(name: name, bio: email, image: null); // bio = email
      notifyListeners();
    }
  }

  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      if (_user != null) {
        _user?.image = File(image.path);
      } else {
        _user = User(name: "User", bio: "Email", image: File(image.path));
      }
      notifyListeners();
    }
  }

  void removeImage() {
    _user?.image = null;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    Navigator.pushReplacementNamed(context, '/login');
  }
}
