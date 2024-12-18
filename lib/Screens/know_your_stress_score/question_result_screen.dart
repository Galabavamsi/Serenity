import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Screens/first_screen.dart';
import 'package:serenity_app/provider/StressCalculator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Provider
    int depressionValue = Provider.of<StressCalculator>(context).depressionValue * 2;
    int anxietyValue = Provider.of<StressCalculator>(context).anxietyValue * 2;
    int stressValue = Provider.of<StressCalculator>(context).stressValue * 2;

    // Result Calculation Logic
    double getPercentage(int value, int maxLimit) {
      return (value >= maxLimit) ? 100.0 : (value / maxLimit) * 100;
    }

    String getResultD(int value) {
      if (value <= 9) {
        return 'Normal';
      } else if (value <= 13) {
        return 'Mild';
      } else if (value <= 20) {
        return 'Moderate';
      } else if (value <= 27) {
        return 'Severe';
      } else {
        return 'Extremely Severe';
      }
    }

    String getResultA(int value) {
      if (value <= 7) {
        return 'Normal';
      } else if (value <= 9) {
        return 'Mild';
      } else if (value <= 14) {
        return 'Moderate';
      } else if (value <= 19) {
        return 'Severe';
      } else {
        return 'Extremely Severe';
      }
    }

    String getResultS(int value) {
      if (value <= 14) {
        return 'Normal';
      } else if (value <= 18) {
        return 'Mild';
      } else if (value <= 25) {
        return 'Moderate';
      } else if (value <= 33) {
        return 'Severe';
      } else {
        return 'Extremely Severe';
      }
    }

    double depressionPercentage = getPercentage(depressionValue, 28);
    double anxietyPercentage = getPercentage(anxietyValue, 20);
    double stressPercentage = getPercentage(stressValue, 34);

    String depressionResult = getResultD(depressionValue);
    String anxietyResult = getResultA(anxietyValue);
    String stressResult = getResultS(stressValue);

    return WillPopScope(
      onWillPop: () async {
        Provider.of<StressCalculator>(context, listen: false).resetValues();
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
                  // Combined Result
                  _buildCombinedCircularChart(context, depressionPercentage, anxietyPercentage, stressPercentage),
                  SizedBox(height: screenHeight * 0.03),
                  // Action Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to FirstScreen, which contains the BottomNavigationBar
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FirstScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                      Provider.of<StressCalculator>(context, listen: false).resetValues();
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

  Widget _buildCombinedCircularChart(BuildContext context, double depressionPercentage, double anxietyPercentage, double stressPercentage) {
    return Column(
      children: [
        Text(
          'Combined Results',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: () {
            final snackBar = SnackBar(content: Text('Depression: ${depressionPercentage.toStringAsFixed(1)}%, Anxiety: ${anxietyPercentage.toStringAsFixed(1)}%, Stress: ${stressPercentage.toStringAsFixed(1)}%'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: SizedBox(
            height: 200,
            width: 200,
            child: SfCircularChart(
              series: <CircularSeries>[
                RadialBarSeries<ChartData, String>(
                  dataSource: [
                    ChartData('Depression', depressionPercentage, Colors.red),
                    ChartData('Anxiety', anxietyPercentage, Colors.orange),
                    ChartData('Stress', stressPercentage, Colors.blue),
                  ],
                  xValueMapper: (ChartData data, _) => data.label,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, _) => data.color,
                  maximumValue: 100,
                  innerRadius: '60%',
                  radius: '100%',
                  cornerStyle: CornerStyle.bothCurve,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.label, this.value, this.color);
  final String label;
  final double value;
  final Color color;
}