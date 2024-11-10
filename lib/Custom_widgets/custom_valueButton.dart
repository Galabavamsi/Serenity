import 'package:flutter/material.dart';

class CustomValueButton extends StatelessWidget{
  final VoidCallback onPressed;
  final String text;
  const CustomValueButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth*0.65,
      child: OutlinedButton(onPressed: onPressed, child:Text(text,
        style: const TextStyle(
          fontFamily: 'SecondFont',
          fontSize: 19,
          color: Colors.black
        ),)),
    );
  }

}