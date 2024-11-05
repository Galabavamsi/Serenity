import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key?key, required this.text, required this.onPressed}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: ElevatedButton(onPressed: onPressed,
        child: Text(text,style: TextStyle(fontSize: 18,fontFamily: 'SecondFont'),),
      ),
    );
  }

}