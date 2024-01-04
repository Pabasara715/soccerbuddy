import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soccerbuddy/Services/auth_service.dart';
import 'package:soccerbuddy/components/my_button.dart';
import 'package:soccerbuddy/components/my_textfield.dart';
import 'package:soccerbuddy/components/square_tile.dart';
import 'package:soccerbuddy/models/users.dart';
import 'package:soccerbuddy/repository/user_repository.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final userRepo = Get.put(UserRepository());
  void createUser(users user) {
    userRepo.creatUser(user);
  }

  //sign user up method
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    void wrongEmailMessage() {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Incorrect Email'),
            );
          });
    }

    void weekPasswordMessage() {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Password should be at least 6 characters'),
            );
          });
    }

    void showPasswordMismatchError() {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Passwords not match'),
            );
          });
    }

    //creating a user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        final user = users(
          username: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        createUser(user);
      } else {
        Navigator.pop(context);
        showPasswordMismatchError();
        return;
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context); //to pop loading circle
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        wrongEmailMessage();
      } else if (e.code == 'weak-password') {
        weekPasswordMessage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.sports_soccer,
                    size: 100,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Let\'s creat an account for you!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  MyButton(
                    text: "Sign Up",
                    onTap: signUserUp,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'assets/img/google.png',
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SquareTile(
                        imagePath: 'assets/img/facebook.png',
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
