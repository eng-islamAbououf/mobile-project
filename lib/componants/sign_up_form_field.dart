import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpFormField extends StatelessWidget {
  SignUpFormField({Key? key,
  required this.txt ,
    required this.controller,
    required this.validator,
    this.keyboardType,
  }) : super(key: key);

  var txt;
  TextEditingController? controller;
  var validator , keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType??TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: txt,
      ),
      validator: validator,
    );
  }
}
