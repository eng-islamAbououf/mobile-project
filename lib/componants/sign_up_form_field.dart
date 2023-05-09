import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpFormField extends StatelessWidget {
  SignUpFormField({Key? key,
  required this.txt ,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscureText,
  }) : super(key: key);

  var txt;
  TextEditingController? controller;
  var validator , keyboardType;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.blue,
      controller: controller,
      obscureText : obscureText?? false ,
      keyboardType: keyboardType??TextInputType.text,
      decoration: InputDecoration(
        labelText: txt,
        filled: true,
        fillColor: Color(0xb3ffffff),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
