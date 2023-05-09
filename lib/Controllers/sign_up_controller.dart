import 'package:flutter/material.dart';

class SignUpController{
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _contactPersonNameController = TextEditingController();
  final _contactPersonPhoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _companyLocationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  get formKey => _formKey;

  get confirmPasswordController => _confirmPasswordController;

  get passwordController => _passwordController;

  get companyLocationController => _companyLocationController;

  get companyAddressController => _companyAddressController;

  get emailController => _emailController;

  get contactPersonPhoneNumberController => _contactPersonPhoneNumberController;

  get contactPersonNameController => _contactPersonNameController;

  get companyNameController => _companyNameController;
}