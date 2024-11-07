import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{
  final TextEditingController Controller;
  final String hintText;

  const CustomTextfield({Key?key,
    required this.Controller,
    required this.hintText
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(

      ),
      child: TextField(
        controller: Controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
        ),
      ),
    );
  }

}