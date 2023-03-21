import 'package:chat_app/Screens/Home/HomeScreen.dart';
import 'package:chat_app/Screens/People/PeopleScreen.dart';
import 'package:chat_app/Screens/Profile/ProfileScreen.dart';
import 'package:chat_app/Screens/SignIn/SignInScreen.dart';
import 'package:chat_app/Screens/SignUp/SignUpScreen.dart';
import 'package:chat_app/Screens/Splash/SplashScreen.dart';
import 'package:chat_app/Screens/Verification/VerifiecationScreen.dart';
import 'package:chat_app/Screens/Welcome/WelcomeScreen.dart';
import 'package:chat_app/Themes/Themes.dart';
import 'package:chat_app/cubit/BlocObserver.dart';
import 'package:chat_app/cubit/Cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat App',
            initialRoute: "/",
            routes: {
              "/": (context) => const SplashScreen(),
              "/WelcomeScreen": (context) => const WelcomeScreen(),
              "/SignUpScreen": (context) => const SignUpScreen(),
              "/SignInScreen": (context) => const SignInScreen(),
              "/VerificationScreen":(context) =>  VerificationScreen(),
              "/HomeScreen": (context) => const HomeScreen(),
              "/PeopleScreen": (context) => PeopleScreen(),
              "/ProfileScreen": (context) => ProfileScreen(),
            },
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}
