import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String data;
  final double? width; // Optional width
  final double? height; // Optional height
  final Color? buttonColor; // Optional button background color

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.data,
    this.width,
    this.height,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width ?? screenWidth * 0.8,
      height: height ?? screenHeight * 0.06,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: buttonColor ?? Colors.pink.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          data,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'SecondFont',
          ),
        ),
      ),
    );
  }
}
