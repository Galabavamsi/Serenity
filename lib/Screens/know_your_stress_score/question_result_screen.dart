import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Screens/first_screen.dart'; // Import FirstScreen instead of HomeScreen
import 'package:serenity_app/provider/StressCalculator.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Provider
    int totalValue = Provider.of<StressCalculator>(context).totalValue;

    // Stress Calculation Logic
    String stressRange;
    Color rangeColor;
    IconData rangeIcon;

    if (totalValue <= 9 && totalValue >= 5) {
      stressRange = 'Low Stress';
      rangeColor = Colors.green;
      rangeIcon = Icons.sentiment_satisfied;
    } else if (totalValue >= 10 && totalValue <= 14) {
      stressRange = 'Moderate Stress';
      rangeColor = Colors.orange;
      rangeIcon = Icons.sentiment_neutral;
    } else if (totalValue >= 15 && totalValue <= 19) {
      stressRange = 'High Stress';
      rangeColor = Colors.redAccent;
      rangeIcon = Icons.sentiment_dissatisfied;
    } else if (totalValue >= 20 && totalValue <= 25) {
      stressRange = 'Very High Stress';
      rangeColor = Colors.red;
      rangeIcon = Icons.sentiment_very_dissatisfied;
    } else {
      stressRange = 'Invalid Input';
      rangeColor = Colors.grey;
      rangeIcon = Icons.error;
    }

    return WillPopScope(
      onWillPop: () async {
        Provider.of<StressCalculator>(context, listen: false).resetValue();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
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
                  // Animated Icon
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: rangeColor.withOpacity(0.2),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      rangeIcon,
                      color: rangeColor,
                      size: 80,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Stress Range Text
                  Text(
                    'Your Stress Level',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'SecondFont',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    stressRange,
                    style: TextStyle(
                      fontFamily: 'ThirdFont',
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: rangeColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Progress Indicator
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: LinearProgressIndicator(
                      value: totalValue / 25,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      color: rangeColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Action Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to FirstScreen, which contains the BottomNavigationBar
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FirstScreen()), // Navigate to FirstScreen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Explore Relaxation Exercises',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Reset Button
                  TextButton(
                    onPressed: () {
                      Provider.of<StressCalculator>(context, listen: false)
                          .resetValue();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Retake Test',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
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
}
