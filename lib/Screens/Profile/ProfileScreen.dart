import 'package:chat_app/cubit/Cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

// firestore.collection("Users").where("id" , isEqualTo : _auth.currentUser!.uid )
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ClipOval(
            child: SizedBox(
              height: 170,
              width: 170,
              child: Image(
                image: NetworkImage("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg"),
              ),
            ),
          ),
          Text("${AppCubit.get(context).theNameOfUser}"),
          Text(_auth.currentUser!.email.toString()),
          IconButton(
            onPressed: () async {
              try {
                await _auth.signOut().then((value) {
                  Navigator.pushNamedAndRemoveUntil(context, "/WelcomeScreen", (route) => false);
                  AppCubit.get(context).currentIndex = 0;
                });
              } on FirebaseException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.code),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
