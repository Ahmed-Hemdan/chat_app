import 'package:chat_app/Models/UserModel.dart';
import 'package:chat_app/cubit/Cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  UserModel user = UserModel();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "You will get a verification message Please check you gmail ^_^",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await AppCubit.get(context).auth.currentUser!.reload().then((value) {
                  AppCubit.get(context).checkEmailVerificationn(context);
                }).then((value) => AppCubit.get(context).getNameOfUser());
              },
              child: const Text("continue"),
            ),
          ],
        ),
      ),
    );
  }
}
