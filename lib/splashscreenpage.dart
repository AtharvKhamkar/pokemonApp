import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/LoginPage.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.cyan.shade50,
      duration: 3000,
      splash: Image.asset("assets/Images/pokeball.png"),
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}