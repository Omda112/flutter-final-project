import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SplashViewModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3)); // Short delay
    final viewModel = Provider.of<SplashViewModel>(context, listen: false);
    String route = await viewModel.decideStartScreen();
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with opacity
          Opacity(
            opacity: 0.60,
            child: Image.asset(
              'assets/splash.jpg', // Make sure this path exists in assets
              fit: BoxFit.cover,
            ),
          ),

          // Optional fade-in animation or logo overlay if needed
          Center(
            child: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

