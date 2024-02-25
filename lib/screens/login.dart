import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

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
  double? latitude;
  double? longitude;
  FirebaseFirestore usersDb = FirebaseFirestore.instance;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      print('Latitude: $latitude, Longitude: $longitude');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                  if (usernameValidation.hasMatch(username) && passwordValidation.hasMatch(password)){
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: username,
                          password: password
                      );
                      DocumentSnapshot userSnapshot =
                        await usersDb.collection('users').doc(credential.user!.uid).get();
                      if (userSnapshot.exists && latitude!=null && longitude!=null){
                        await userProvider.login(
                          credential.user!.uid,
                          userSnapshot['email'],
                          userSnapshot['Name'],
                          latitude!,
                          longitude!,
                          userSnapshot['phone'],
                        );
                        Navigator.pop(context);
                        if (userSnapshot['role']=='Business'){
                          Navigator.pushNamed(
                            context,
                            'businessBottomNavbar',
                          );
                        }
                        else if(userSnapshot['role']=='Customer') {
                          Navigator.pushNamed(
                            context,
                            'userBottomNavbar',
                          );
                        }
                        else{
                          Navigator.pushNamed(
                            context,
                            'farmersBottomNavbar'
                          );
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      showSnackbar(context, "User could not be logged in");
                      if (e.code == 'user-not-found') {
                        showSnackbar(context, "Username not found");
                      } else if (e.code == 'wrong-password') {
                        showSnackbar(context, "Username and password doesn't match");
                      }
                    }
                  }
                  else{
                    showSnackbar(context, "Invalid Username or Password");
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
