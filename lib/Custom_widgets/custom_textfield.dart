import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{
  final TextEditingController Controller;
  final String hintText;

  const CustomTextfield({super.key,
    required this.Controller,
    required this.hintText
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(

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