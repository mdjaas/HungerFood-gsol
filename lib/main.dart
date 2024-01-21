import 'package:flutter/material.dart';

import 'package:g_solution/screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Solution Challenge',
      home: LandingScreen(),
    );
  }
}