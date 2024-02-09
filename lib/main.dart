import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:g_solution/screens/signup_page2.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:g_solution/screens/landing_page.dart';
import 'package:g_solution/screens/business_bottom_navbar.dart';
import 'package:g_solution/screens/login.dart';
import 'package:g_solution/screens/signup_page1.dart';
import 'package:g_solution/screens/signup_page2.dart';
import 'package:g_solution/screens/users_bottom_navbar.dart';
import 'package:g_solution/screens/business_add_product.dart';
import 'package:g_solution/providers/user_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UserProvider().checkLoggedIn();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solution Challenge',
      initialRoute: 'landingScreen',
      routes:{
        'landingScreen': (context) => const LandingScreen(),
        'businessBottomNavbar': (context) => const BusinessBottomNavbar(),
        'login': (context) => LoginScreen(),
        'gettingStarted': (context) => const GettingStarted(),
        'signupScreen': (context) => const SignUp(),
        'userBottomNavbar': (context) => const UserBottomNavbar(),
        'businessAddProduct': (context) => BusinessAddProduct(),

      },
    );
  }
}