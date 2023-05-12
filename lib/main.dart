import 'package:flutter/material.dart';
import 'package:mobile_project/provider/edit_profile_provider.dart';
import 'package:mobile_project/provider/sign_in_provider.dart';
import 'package:mobile_project/provider/sign_up_provider.dart';
import 'package:mobile_project/view/edit_profile.dart';
import 'package:mobile_project/view/sign_in.dart';
import 'package:mobile_project/view/sign_up.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> SignUpProvider()),
        ChangeNotifierProvider(create: (_)=> EditProfileProvider()),
        ChangeNotifierProvider(create: (_)=> SignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
        ),
    );
  }
}