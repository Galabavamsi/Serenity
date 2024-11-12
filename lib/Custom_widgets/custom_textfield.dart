import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextfield({super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(

      ),
      child: TextField(
        controller: controller,
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