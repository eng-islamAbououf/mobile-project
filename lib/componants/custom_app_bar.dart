import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.height , required this.title
    , this.action
  }) : super(key: key);
  double height;
  String title;
  Widget? action ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.12,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Text(title.toUpperCase() , style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        actions: action!=null? [
          action!
        ] : null,
        // Other AppBar properties, such as title or actions, can be added here
      ),
    );
  }
}
