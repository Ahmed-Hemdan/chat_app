import 'package:chat_app/cubit/Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade100,
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: AppCubit.get(context).currentIndex,
              onDestinationSelected: (value) {
                AppCubit.get(context).changeCurrentIndex(value);
              },
              destinations: AppCubit.get(context).bottomNavItem,
            ),
          ),
          body: AppCubit.get(context)
              .screenList[AppCubit.get(context).currentIndex],
        );
      },
    );
  }
}
