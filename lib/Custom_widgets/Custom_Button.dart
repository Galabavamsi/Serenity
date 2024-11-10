import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(onPressed: onPressed,
        child: Text(text,style: const TextStyle(fontSize: 18,fontFamily: 'SecondFont'),),
      ),
    );
  }

}