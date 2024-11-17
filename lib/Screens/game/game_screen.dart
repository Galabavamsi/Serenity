import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math';

class BubblePopGameScreen extends StatefulWidget {
  const BubblePopGameScreen({super.key});

  @override
  _BubblePopGameScreenState createState() => _BubblePopGameScreenState();
}

class _BubblePopGameScreenState extends State<BubblePopGameScreen> {
  int score = 0;
  int timeLeft = 60;
  List<Widget> bubbles = [];
  Timer? gameTimer;
  Random random = Random();
  AudioPlayer audioPlayer = AudioPlayer(); // For bubble pop sound

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      spawnBubbles();
      startGameTimer();
    });
  }

  // Start game timer
  void startGameTimer() {
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        showGameOverDialog();
      }
    });
  }

  // Show game over dialog
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score: $score\nKeep it up!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  // Reset game
  void resetGame() {
    setState(() {
      score = 0;
      timeLeft = 60;
      bubbles.clear();
      spawnBubbles();
      startGameTimer();
    });
  }

  // Spawn bubbles at random positions
  void spawnBubbles() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      for (int i = 0; i < 6; i++) {
        bubbles.add(createBubble(screenWidth, screenHeight));
      }
    });
  }

  // Play bubble pop sound
  void playPopSound() async {
    try {
      await audioPlayer.play(AssetSource('images/bubble.mp3'));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  // Create a bubble widget
  Widget createBubble(double screenWidth, double screenHeight) {
    double xPos = random.nextDouble() * (screenWidth - 80);
    double yPos = random.nextDouble() * (screenHeight - 200);

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: xPos,
      top: yPos,
      child: GestureDetector(
        onTap: () {
          playPopSound(); // Play sound on tap
          setState(() {
            score += 1;
            bubbles.removeAt(0);
            bubbles.add(createBubble(screenWidth, screenHeight));
          });
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue.withOpacity(0.6),
          child: Icon(
            Icons.spa,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bubble Pop",
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Stack(children: bubbles),
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Time Left: $timeLeft",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'SecondFont'),
                ),
                Text(
                  "Score: $score",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'SecondFont'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }
}
