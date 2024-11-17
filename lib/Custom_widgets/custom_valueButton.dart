import 'package:flutter/material.dart';

class CustomValueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle; // Optional text style
  final Color? buttonColor; // Optional button background color

  const CustomValueButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: buttonColor ?? Colors.transparent, // Optional background color
      child: SizedBox(
        width: screenWidth * 0.65,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  fontFamily: 'SecondFont',
                  fontSize: 19,
                  color: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}
