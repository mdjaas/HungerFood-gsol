import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';

class SignUp extends StatefulWidget{
  final String? userRole;

  const SignUp({
    super.key,
    this.userRole,
  });

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String username="";
  String password="";
  String name="";
  FirebaseFirestore db = FirebaseFirestore.instance;

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        iconThemeColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.25,),
                  TextFieldWidget(
                    textEditingController: _nameController,
                    placeholder: 'Name',
                    onTextChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textEditingController: _usernameController,
                    onTextChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    placeholder: 'Username',
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textEditingController: _passwordController,
                    onTextChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    placeholder: 'Password',
                    secure: true,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWellWidget(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      fontSize: 20,
                      buttonName: 'Sign Up',
                      onPress: () async {
                        try {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: username,
                            password: password,
                          );

                          await db.collection('users').doc(credential.user!.uid).set({
                            'Name': name,
                            'email': username,
                            'role': widget.userRole,
                            'phone': 0,
                          });
                          showSnackbar(context, "Account created successfully");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackbar(context,'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackbar(context,'The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
