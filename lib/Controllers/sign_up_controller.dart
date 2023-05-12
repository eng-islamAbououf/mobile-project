import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final Completer<GoogleMapController> _mapController = Completer();

  get formKey => _formKey;

  get confirmPasswordController => _confirmPasswordController;

  get passwordController => _passwordController;

  get companyLocationController => _companyLocationController;

  get companyAddressController => _companyAddressController;

  get emailController => _emailController;

  get contactPersonPhoneNumberController => _contactPersonPhoneNumberController;

  get contactPersonNameController => _contactPersonNameController;

  get companyNameController => _companyNameController;

  String? validateConfirmPassword(String? value){
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 8) {
      return 'Confirm password must be at least 8 characters';
    } else if (value != _passwordController.text) {
      return 'Confirm password must match password';
    }
    return null;
  }

  Completer<GoogleMapController> get mapController => _mapController;
}