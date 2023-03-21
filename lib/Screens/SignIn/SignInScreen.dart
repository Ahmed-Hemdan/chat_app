import 'package:chat_app/cubit/Cubit.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/WelcomeScreen");
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Sign in ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value != null && EmailValidator.validate(value)) {
                          return null;
                        } else {
                          return 'Please enter a valid email !!';
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Email',
                          style: TextStyle(fontSize: 15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 370,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.length < 6 || value.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                          style: TextStyle(fontSize: 15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AppCubit.get(context)
                              .singin(
                                context,
                                emailController.text,
                                passwordController.text,
                              )
                              .then((value) => AppCubit.get(context).getNameOfUser())
                              .then(
                                (value) => Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (route) => false),
                              );
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
