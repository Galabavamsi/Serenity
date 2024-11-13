import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // You can adjust the width based on your design needs
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
