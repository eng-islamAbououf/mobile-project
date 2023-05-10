import 'package:flutter/material.dart';
import 'package:mobile_project/provider/sign_up_provider.dart';
import 'package:mobile_project/view/sign_up.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_)=> SignUpProvider(),
          child: SignupScreen()),
    );
  }
}