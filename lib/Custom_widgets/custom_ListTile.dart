import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;

  // Constructor to accept title, content, and date as parameters
  const CustomListTile({
    super.key,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        leading: const FaIcon(
          FontAwesomeIcons.faceSmile,
          size: 48,
        ),
        title: Text(
          'Date: ${date.day}/${date.month}/${date.year}',
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'SecondFont',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SecondFont',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'SecondFont',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
