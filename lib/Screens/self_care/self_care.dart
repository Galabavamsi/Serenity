import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add Lottie for animations
import 'package:serenity_app/Screens/game/game_screen.dart'; // Import the Bubble Pop game screen
import 'package:serenity_app/Screens/game/game_screen2.dart'; // Import the Jigsaw Puzzle game screen

class SelfCare extends StatelessWidget {
  const SelfCare({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: Text(
          'Self Care',
          style: TextStyle(
            fontFamily: 'SecondFont',
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: screenWidth * 0.9,
            height: screenHeight * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
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
                // Animated Illustration
                Lottie.asset(
                  'assets/animations/relaxation.json', // Add your Lottie file in the assets
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.7,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Motivational Quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '"Feeling stressed? Take a break and relax with a calming game designed to ease your mind and lift your spirits."',
                    style: TextStyle(
                      fontFamily: 'SecondFont',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Start Bubble Pop Game Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return BubblePopGameScreen();
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.pink.shade300,
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: screenWidth * 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.pink.shade200,
                  ),
                  icon: Icon(Icons.play_arrow, size: 28),
                  label: Text(
                    'Bubble Pop Game',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ThirdFont',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Start Puzzle Game Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return JigsawPuzzleGame();
                        }));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.purple.shade300,
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: screenWidth * 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.purple.shade200,
                  ),
                  icon: Icon(Icons.extension, size: 28),
                  label: Text(
                    'Puzzle Game',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ThirdFont',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Subtle Hint
                Text(
                  'Games are a great way to de-stress!',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ThirdFont',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}