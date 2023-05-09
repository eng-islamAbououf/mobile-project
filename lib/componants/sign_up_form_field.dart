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
    debugPrint("islam") ;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType??TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          labelText: txt,
          filled: true,
          fillColor: Colors.white,
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
      ),
    );
  }
}
