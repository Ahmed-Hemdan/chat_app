import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Profile'),
        Text(_auth.currentUser!.email.toString()),
        Text(_auth.currentUser!.uid),
        IconButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, "/WelcomeScreen", (route) => false);
          },
          icon: const Icon(
            Icons.logout_outlined,
            size: 25,
          ),
        ),
      ],
    );
  }
}
