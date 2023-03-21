import 'package:chat_app/cubit/Cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final emailregex = RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*");

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Sign up ",
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
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            'Name',
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
                            AppCubit.get(context).userName = nameController.text;
                            AppCubit.get(context).userEmail = emailController.text;
                            AppCubit.get(context).userPassword = passwordController.text;
                            AppCubit.get(context).registerNewUser(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: const Text(
                          'Sign up',
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
      ),
    );
  }
}
