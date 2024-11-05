import 'package:flutter/material.dart';
import 'dart:math';

class BubblePopGameScreen extends StatefulWidget {
  @override
  _BubblePopGameScreenState createState() => _BubblePopGameScreenState();
}

class _BubblePopGameScreenState extends State<BubblePopGameScreen> {
  int score = 0;
  List<Widget> bubbles = [];

  @override
  void initState() {
    super.initState();
    spawnBubbles();
  }

  // Function to spawn bubbles at random positions
  void spawnBubbles() {
    for (int i = 0; i < 4; i++) {
      bubbles.add(createBubble());
    }
  }

  // Function to create a bubble
  Widget createBubble() {
    Random random = Random();
    double xPos = random.nextDouble() * 300;
    double yPos = random.nextDouble() * 500;

    return Positioned(
      left: xPos,
      top: yPos,
      child: GestureDetector(
        onTap: () {
          setState(() {
            score += 1;
            bubbles.removeAt(0);
            bubbles.add(createBubble());
          });
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.pink.withOpacity(0.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble Pop",style: TextStyle(
            fontFamily: 'SecondFont'
        ),),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Container(
        child: Stack(
          children: [
            Stack(children: bubbles), // Display the bubbles on the screen
            Positioned(
              top: 20,
              right: 20,
              child: Text(
                "Score: $score",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'SecondFont'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
