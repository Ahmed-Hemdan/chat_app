import 'package:chat_app/cubit/Cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  String imageUrl = "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipOval(
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: BlocConsumer<AppCubit, AppCubitState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Image(
                        image: NetworkImage(imageUrl),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: ClipOval(
                  child: Container(
                    color: Colors.blueAccent[100],
                    child: IconButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 5,
                                color: Colors.yellow,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.blueAccent[100],
                                          child: IconButton(
                                            onPressed: () {
                                              AppCubit.get(context).getImageFromGallery().then((value) => AppCubit.get(context).uploadPhotoToFirebase()).then((value) => imageUrl = AppCubit.get(context).downloadURL!);
                                            },
                                            icon: const Icon(
                                              Icons.collections_outlined,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipOval(
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          color: Colors.blueAccent[100],
                                          child: IconButton(
                                            onPressed: () {
                                              AppCubit.get(context).getImageFromCamera().then((value) => AppCubit.get(context).uploadPhotoToFirebase()).then((value) => imageUrl = AppCubit.get(context).downloadURL!);
                                            },
                                            icon: const Icon(
                                              Icons.camera,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ),
              ),
            ],
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
