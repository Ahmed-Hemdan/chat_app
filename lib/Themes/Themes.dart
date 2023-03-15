import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.black,
        ),
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 30,
      ),
      textTheme: const TextTheme(
        bodyLarge:  TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
      primarySwatch: Colors.blue,
    );

ThemeData lightTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 30,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
        bodyMedium: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
      primaryColor: Colors.blue,
      primarySwatch: Colors.blue,
    );
