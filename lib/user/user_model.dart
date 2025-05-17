import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String name;
  String email;
  String password;
  File? image;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'image_path': image?.path,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'],
    email: json['email'],
    password: json['password'],
    image: json['image_path'] != null && File(json['image_path']).existsSync()
        ? File(json['image_path'])
        : null,
  );

  // Load UserModel from SharedPreferences
  static Future<UserModel?> fromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');
    final password = prefs.getString('user_password');
    final imagePath = prefs.getString('user_image_path');

    if (name != null && email != null && password != null) {
      File? imageFile = (imagePath != null && File(imagePath).existsSync()) ? File(imagePath) : null;
      return UserModel(name: name, email: email, password: password, image: imageFile);
    }
    return null;
  }
}
