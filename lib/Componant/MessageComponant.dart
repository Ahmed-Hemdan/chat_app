import 'package:flutter/material.dart';

Widget anotherMessage(String message) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );

Widget myMessage(String message) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
