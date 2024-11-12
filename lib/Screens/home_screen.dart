// This is the home widget screen

import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/call_an_expert/call_expert.dart';
import 'package:serenity_app/Screens/habits/habits.dart';
import 'package:serenity_app/Screens/know_your_mood/face_tracking_screen.dart';
import 'package:serenity_app/Screens/know_your_stress_score/question_1_screen.dart';
import 'package:serenity_app/Screens/self_care/self_care.dart';
import '../Custom_widgets/custom_outlinedButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text(
          'SERENITY',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: screenWidth * 0.9,
              height: screenHeight * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Shadow color
                    blurRadius: 20, // Softening the shadow
                    offset: Offset(0, 5), // Positioning the shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Question1();
                        }));
                      },
                      data: 'Know Your Stress score'),
                  CustomOutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const FaceTracking();
                        }));
                      },
                      data: 'Know Your Mood'),
                  CustomOutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Habits();
                        }));
                      },
                      data: 'Habits'),
                  CustomOutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SelfCare();
                        }));
                      },
                      data: 'Self care'),
                  CustomOutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CallExpert();
                        }));
                      },
                      data: 'Call An Expert'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
