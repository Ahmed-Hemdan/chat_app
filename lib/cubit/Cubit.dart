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
    const PeopleScreen(),
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexForScreens());
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").add(user.toJson());
    } catch (error) {
      print(error);
    }
    emit(CreateUserToFirebase());
  }

  UserModel user = UserModel();
  void checkEmailVerificationn(BuildContext context) {
    if (AppCubit.get(context).auth.currentUser!.emailVerified == true) {
      user = UserModel(
        name: AppCubit.get(context).nameController.text,
        email: AppCubit.get(context).emailController.text,
        id: AppCubit.get(context).auth.currentUser!.uid,
        password: AppCubit.get(context).passwordController.text,
      );
      AppCubit.get(context).createUser(user).then((value) {
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
      print(AppCubit.get(context).auth.currentUser!.email);
      print(AppCubit.get(context).auth.currentUser!.emailVerified);
    }
    emit(CheckEmailVerification());
  }
//   final FirebaseStorage storage = FirebaseStorage.instance;

// final Reference reference = storage.ref().child('profile_images/${userId}');

// final ImagePicker _picker = ImagePicker();

// final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// final File file = File(image!.path);

// final TaskSnapshot taskSnapshot = await reference.putFile(file);

// final String imageUrl = await taskSnapshot.ref.getDownloadURL();
}
