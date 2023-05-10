import 'package:flutter/material.dart';
import 'package:mobile_project/view/sign_in.dart';
import 'package:mobile_project/view/sign_up.dart';

void main() {
  runApp( SignInScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}