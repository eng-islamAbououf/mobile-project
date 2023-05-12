import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget {
  FailureDialog({Key? key , required this.errorMsg}) : super(key: key);
  String errorMsg;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Icon(Icons.close, color: Colors.red),
          SizedBox(height: 10),
          Text('Faild'),
        ],
      ),
      content: Text(errorMsg),
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
