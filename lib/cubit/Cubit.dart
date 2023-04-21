import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/Models/MessageModel.dart';
import 'package:chat_app/Models/UserModel.dart';
import 'package:chat_app/Screens/People/PeopleScreen.dart';
import 'package:chat_app/Screens/Profile/ProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'State.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screenList = [
    PeopleScreen(),
    ProfileScreen(),
  ];
  List<String> screenName = const [
    'People',
    'Profiel',
  ];
  List<NavigationDestination> bottomNavItem = const [
    NavigationDestination(
      icon: Icon(
        Icons.supervised_user_circle_outlined,
      ),
      label: 'People',
    ),
    NavigationDestination(
      icon: Icon(
        Icons.account_circle_outlined,
      ),
      label: 'Profile',
    ),
  ];
  int currentIndex = 0;

  final _db = FirebaseFirestore.instance;

  String? userName;
  String? userEmail;
  String? userPassword;
  FirebaseAuth auth = FirebaseAuth.instance;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexForScreens());
  }

  registerNewUser(context, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) async {
          await auth.currentUser!.sendEmailVerification().then(
                (value) => Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/VerificationScreen",
                  (route) => false,
                ),
              );
        },
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
    emit(RegisterNewUserInOuthentication());
  }

  Future<void> createUserOnCollection(UserModel user) async {
    try {
      await _db.collection("Users").doc(auth.currentUser!.uid).set(user.toJson());
    } catch (error) {
      print(error.toString());
    }
    emit(CreateUserToFirebase());
  }

  singin(context, String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => getNameOfUser(),
          )
          .then(
            (value) => Navigator.pushNamedAndRemoveUntil(
              context,
              "/HomeScreen",
              (route) => false,
            ),
          );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
    emit(SignIn());
  }

  UserModel user = UserModel();
  void checkEmailVerificationn(BuildContext context) {
    if (auth.currentUser!.emailVerified == true) {
      user = UserModel(
        name: userName,
        email: userEmail,
        id: auth.currentUser!.uid,
        password: userPassword,
      );
      createUserOnCollection(user).then((value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/HomeScreen",
          (route) => false,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please verifie your email first ",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    }
    emit(CheckEmailVerification());
  }

  String? theNameOfUser;
  getNameOfUser() async {
    await _db.collection("Users").where("id", isEqualTo: auth.currentUser!.uid).get().then(
          (value) => {
            value.docs.forEach(
              (element) {
                theNameOfUser = element.data()["name"];
              },
            ),
          },
        );
    emit(GetTheNameOfUser());
  }

  Future<void> creatChatCollectoin(String anotherUserUid) async {
    try {
      _db.collection("Chats").doc("${auth.currentUser!.uid}+$anotherUserUid");
    } catch (e) {
      null;
    }
  }

  MessageModel? message;
  String? theMessage;
  String? anotherUserId;
  String? anotherUserName;

  Future<void> creatConversationInCollection() async {
    try {
      String time = DateTime.now().toString();
      message = MessageModel(messsage: theMessage, id: auth.currentUser!.uid, time: time);
      await _db
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Chats")
          .doc(anotherUserId)
          .collection("messages")
          .add(
            message!.toJson(),
          )
          .then((value) => _db.collection("Users").doc(anotherUserId).collection("Chats").doc(auth.currentUser!.uid).collection("messages").add(
                message!.toJson(),
              ));
    } catch (e) {
      null;
    }
    emit(CreatConversationInCollection());
  }

  var image;
  String? downloadURL;
  getImageFromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  getImageFromCamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  uploadPhotoToFirebase() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/${auth.currentUser!.uid}.jpg');
      File file = File(image.path);
      Uint8List imageBytes = await file.readAsBytes();
      UploadTask uploadTask = ref.putData(imageBytes);
      downloadURL = await ref.getDownloadURL();
      print(downloadURL);
    } catch (e) {
      print(e.toString());
    }
    emit(UploadImageToFirebase());
  }
}
