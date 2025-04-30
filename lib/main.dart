import 'package:firstproject/add_item/item_model.dart';
import 'package:firstproject/dashboard/nav_bar.dart';
import 'package:firstproject/favorite/favorite_model.dart';
import 'package:firstproject/profile/user_model.dart';
import 'package:firstproject/signUp/sign_up_screen.dart';
import 'package:firstproject/signUp/sign_up_view_model.dart';
import 'package:firstproject/splash/SplashViewModel.dart';
import 'package:firstproject/splash/splash_screen.dart'; // ⭐ Import splash screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/LoginScreen.dart';
import 'login/LoginViewModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()), // ❗ Rename if needed
        ChangeNotifierProvider(create: (context) => ItemModel()),
        ChangeNotifierProvider(create: (context) => FavoriteModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => SplashViewModel()),  // إضافة ViewModel
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // 👈 Start with splash
      routes: {
        '/': (context) => const SplashScreen(),     // 🔄 Splash
        '/signup': (context) => SignUpScreen(), // 📝 Sign Up
        '/dashboard': (context) => const NavBar(),   // 🏠 Main App (NavBar)
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
