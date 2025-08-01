import 'package:flutter/material.dart';
import 'package:blood_link/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodLink App',
      theme: ThemeData(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
