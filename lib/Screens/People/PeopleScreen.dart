import 'package:chat_app/cubit/Cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class PeopleScreen extends StatelessWidget {
  PeopleScreen({Key? key}) : super(key: key);
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("Users").snapshots(),
          builder: (context, snapShot) {
            return snapShot.hasError
                ? const Center(
                    child: Text("Error"),
                  )
                : snapShot.hasData
                    ? Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapShot.data!.docs.length,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                AppCubit.get(context).anotherUserName = "${snapShot.data!.docs[index]["name"]}";
                                AppCubit.get(context).anotherUserId = "${snapShot.data!.docs[index]["id"]}";
                                Navigator.pushNamed(context, "/MessagesScreen");
                              },
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Image(
                                            image: NetworkImage(
                                              "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("${snapShot.data!.docs[index]["name"]}")
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
          },
        )
      ],
    );
  }
}
