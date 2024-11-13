import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Increased width to better fit text
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12), // Adjusted padding for a balanced look
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'SecondFont',
          ),
          overflow: TextOverflow.ellipsis, // Prevents text overflow
          maxLines: 1, // Ensures text stays on one line
        ),
      ),
    );
  }
}
