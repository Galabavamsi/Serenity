import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Screens/know_your_stress_score/question_18.dart';
import 'package:serenity_app/provider/StressCalculator.dart';

class Question17 extends StatefulWidget {
  const Question17({super.key});

  @override
  State<Question17> createState() => _Question17State();
}

class _Question17State extends State<Question17> {
  int? selectedOption;

  void _navigateToNextQuestion(BuildContext context, int rating) {
    // Save the selected rating
    Provider.of<StressCalculator>(context, listen: false).addRating(rating, 'd');

    // Navigate to the next question
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Question18()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text(
          'Know your Stress Score',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: screenWidth * 0.9,
              height: screenHeight * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Progress Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LinearProgressIndicator(
                      value: 0.810, // Representing progress (170%)
                      color: Colors.pink,
                      backgroundColor: Colors.pink.shade100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Question 17',
                    style: TextStyle(fontSize: 35, fontFamily: 'SecondFont'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'I felt I wasn’t worth much as a person',
                    style: TextStyle(
                      fontFamily: 'ThirdFont',
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Options
                  ...List.generate(
                    4,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // On selecting an option, navigate to the next question
                          _navigateToNextQuestion(context, index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: selectedOption == index
                                ? Colors.pink.shade100
                                : Colors.white,
                            border: Border.all(
                              color: selectedOption == index
                                  ? Colors.pink
                                  : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _getOptionText(index),
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ThirdFont',
                                fontWeight: FontWeight.w600,
                                color: selectedOption == index
                                    ? Colors.pink.shade900
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getOptionText(int index) {
    switch (index) {
      case 0:
        return 'Did not apply to me at all';
      case 1:
        return 'Applied to me to some degree, or some of the time';
      case 2:
        return 'Applied to me to a considerable degree or a good part of time';
      case 3:
        return 'Applied to me very much or most of the time';
      default:
        return '';
    }
  }
}