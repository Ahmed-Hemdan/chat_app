import 'package:chat_app/Screens/People/PeopleScreen.dart';
import 'package:chat_app/Screens/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'State.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screenList =  [
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
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexForScreens());
  }
}
