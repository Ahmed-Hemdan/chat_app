import 'package:chat_app/Models/UserModel.dart';
import 'package:chat_app/Screens/People/PeopleScreen.dart';
import 'package:chat_app/Screens/Profile/ProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      print(error);
    }
    emit(CreateUserToFirebase());
  }

  singin(context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
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
      AppCubit.get(context).createUserOnCollection(user).then((value) {
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
      print(auth.currentUser);
      print(AppCubit.get(context).auth.currentUser!.email);
      print(AppCubit.get(context).auth.currentUser!.emailVerified);
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

//   final FirebaseStorage storage = FirebaseStorage.instance;

// final Reference reference = storage.ref().child('profile_images/${userId}');

// final ImagePicker _picker = ImagePicker();

// final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// final File file = File(image!.path);

// final TaskSnapshot taskSnapshot = await reference.putFile(file);

// final String imageUrl = await taskSnapshot.ref.getDownloadURL();
}
