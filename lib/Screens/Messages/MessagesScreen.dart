import 'package:chat_app/Componant/MessageComponant.dart';
import 'package:chat_app/cubit/Cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});
  final firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue,
        title: Text('${AppCubit.get(context).anotherUserName}'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection("Users").doc(AppCubit.get(context).auth.currentUser!.uid).collection("Chats").doc(AppCubit.get(context).anotherUserId).collection("messages").orderBy("time").snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasError
                        ? const Center(
                            child: Text("Error"),
                          )
                        : snapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.docs[index]["id"] == AppCubit.get(context).auth.currentUser!.uid) {
                                      return myMessage(snapshot.data!.docs[index]["message"]);
                                    } else {
                                      return anotherMessage(snapshot.data!.docs[index]["message"]);
                                    }
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BlocConsumer<AppCubit, AppCubitState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return TextFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please write your message first';
                              } else if (messageController.text == '') {
                                return 'Please write your message first';
                              } else {
                                null;
                              }
                            },
                            controller: messageController,
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                hintText: "Write your message",
                                border: InputBorder.none),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AppCubit.get(context).theMessage = messageController.text;
                          AppCubit.get(context).creatConversationInCollection().then(
                                (value) => messageController.clear(),
                              );
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
