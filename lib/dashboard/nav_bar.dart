import 'package:firstproject/dashboard/dashboard_screen.dart';
import 'package:firstproject/favorite/favorite_screen.dart';
import 'package:firstproject/profile/profile_page/profile_screen.dart';
import 'package:firstproject/quote/quote_screen.dart';
import 'package:firstproject/signUp/sign_up_screen.dart';
import 'package:firstproject/task/task_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: [
        DashboardScreen(),
        QuoteScreen(),
        FavoriteScreen(),
        ProfilePage(),
        SignUpScreen(),
      ][_selectedIndex],

      bottomNavigationBar: NavigationBar(

          onDestinationSelected: (index){
            setState(() {
              _selectedIndex = index;
            });
          } ,

          destinations: [
        NavigationDestination(icon: Icon(Icons.dashboard), label: "Dashboard"),
            NavigationDestination(icon: Icon(Icons.format_quote), label: "Quote"),
        NavigationDestination(icon: Icon(Icons.favorite), label: "Favorite"),
        NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: "Profile"),
            // NavigationDestination(icon: Icon(Icons.accessibility), label: "Sign"),

          ]),
    );
  }
}
