

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_project/provider/edit_profile_provider.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:mobile_project/provider/sign_in_provider.dart';
import 'package:mobile_project/provider/sign_up_provider.dart';
import 'package:mobile_project/view/edit_profile.dart';
import 'package:mobile_project/view/home_screen.dart';
import 'package:mobile_project/view/sign_in.dart';
import 'package:mobile_project/view/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory() ;
  await Hive.initFlutter(directory.path);
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
        ChangeNotifierProvider(create: (_)=> HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
        ),
    );
  }
}