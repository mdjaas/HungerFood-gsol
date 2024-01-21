import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'signup_page1.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'business_products.dart';
import 'package:g_solution/widgets/bottom_navbar_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),

            Padding(padding: EdgeInsets.only(left: 100, right: 100),
              child: InkWellWidget(
                onPress: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavbarWidget(),
                    ),
                  );
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
                        text:"Don't have an account?",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(fontSize: 20, color: Colors.green),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const GettingStarted(),
                              ),
                            );
                          }
                      )
                    ]
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
