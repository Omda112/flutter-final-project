import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  final File ? selectedImage;
  final VoidCallback   onPressed;
  const Options({this.selectedImage,required this.onPressed  ,required this.title ,required this.icon,super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: selectedImage==null? Colors.grey.shade800:Colors.red,
          onPressed:onPressed,
          icon: Icon(icon), // IconButton
        ),
        Text(title,style: TextStyle(color: selectedImage==null? Colors.grey.shade800:Colors.red),),
      ],
    );
  }
}
