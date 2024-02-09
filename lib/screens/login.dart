import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'signup_page1.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final RegExp usernameValidation = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp passwordValidation = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+=!])(?=.*[^\w\d\s]).{8,}$');
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String username = "";
  String password = "";
  FirebaseFirestore usersDb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _usernameController,
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextField(
                controller: _passwordController,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: InkWellWidget(
                onPress: () async {
                  // Access username using the state variable
                  print("Username entered: $username");

                  if (usernameValidation.hasMatch(username) && passwordValidation.hasMatch(password)){
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: username,
                          password: password
                      );
                      DocumentSnapshot userSnapshot =
                        await usersDb.collection('users').doc(credential.user!.uid).get();
                      if (userSnapshot.exists){
                        await userProvider.login(
                          credential.user!.uid,
                          userSnapshot['email'],
                          userSnapshot['Name'],
                        );
                        Navigator.pop(context);
                        if (userSnapshot['role']=='Business'){
                          Navigator.pushNamed(
                            context,
                            'businessBottomNavbar',
                          );
                        }
                        else{
                          Navigator.pushNamed(
                            context,
                            'userBottomNavbar',
                          );
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  }

                },
                padding: EdgeInsets.only(top: 10, bottom: 10),
                buttonName: 'Login',
                fontSize: 20,
              ),
            ),

            // Additional widgets can be added below
            SizedBox(height: 170),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    TextSpan(
                      text: "Sign Up",
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GettingStarted(),
                            ),
                          );
                        },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}