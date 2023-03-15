import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/Screens/Welcome/WelcomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        duration: 500,
        splash: const Icon(
          Icons.mark_unread_chat_alt_outlined,
          color: Colors.blue,
          size: 130,
        ),
        nextScreen: const WelcomeScreen(),
      ),
    );
  }
}
