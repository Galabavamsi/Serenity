import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // Optional icon
  final ButtonStyle? style; // Optional custom style

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Fixed width for uniformity
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: style ?? ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: icon != null
            ? Icon(icon, size: 20) // Optional icon rendering
            : const SizedBox.shrink(),
        label: Text(
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
