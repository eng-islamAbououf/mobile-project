import 'package:flutter/material.dart';

class EditProfileController{

  final _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _password = TextEditingController();

  get formKey => _formKey;
  final _addressController = TextEditingController();

  get nameController => _nameController;

  get contactNameController => _contactNameController;

  get phoneNumberController => _phoneNumberController;

  get emailController => _emailController;

  get password => _password;

  get addressController => _addressController;
}