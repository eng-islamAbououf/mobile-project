import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  SuccessDialog({Key? key , required this.msg}) : super(key: key);
  String msg;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(height: 10),
          Text('Success'),
        ],
      ),
      content: Text(msg),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
