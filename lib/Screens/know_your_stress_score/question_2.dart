import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Screens/know_your_stress_score/question_3.dart';
import 'package:serenity_app/provider/StressCalculator.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  int? selectedOption;

  void _navigateToNextQuestion(BuildContext context, int rating) {
    // Save the selected rating
    Provider.of<StressCalculator>(context, listen: false).addRating(rating);

    // Navigate to the next question
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  Question3()),
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
                      value: 0.2, // Representing progress (20%)
                      color: Colors.pink,
                      backgroundColor: Colors.pink.shade100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Question 2',
                    style: TextStyle(fontSize: 35, fontFamily: 'SecondFont'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'How frequently do you experience difficulty sleeping due to worries or stress?',
                    style: TextStyle(
                      fontFamily: 'ThirdFont',
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Options
                  ...List.generate(
                    5,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // On selecting an option, navigate to the next question
                          _navigateToNextQuestion(context, index + 1);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: selectedOption == index + 1
                                ? Colors.pink.shade100
                                : Colors.white,
                            border: Border.all(
                              color: selectedOption == index + 1
                                  ? Colors.pink
                                  : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _getOptionText(index + 1),
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ThirdFont',
                                fontWeight: FontWeight.w600,
                                color: selectedOption == index + 1
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
      case 1:
        return 'Never';
      case 2:
        return 'Rarely';
      case 3:
        return 'Sometimes';
      case 4:
        return 'Often';
      case 5:
        return 'Always';
      default:
        return '';
    }
  }
}
