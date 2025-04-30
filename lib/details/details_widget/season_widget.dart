import 'package:flutter/material.dart';

class MySeason extends StatelessWidget {
  String url;
  String text;
  MySeason({ required this.url , required this.text , super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
            height: 100,
            width: 100,
            fit:BoxFit.cover,
            url),
        Text(text ,style: TextStyle(color: Colors.white , fontSize: 25),
        )
      ],
    );

  }
}