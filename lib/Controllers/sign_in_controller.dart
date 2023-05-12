
import 'package:flutter/material.dart';

class SignInController{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  get formKey => _formKey;

  get passwordController => _passwordController;

  get emailController => _emailController;

}