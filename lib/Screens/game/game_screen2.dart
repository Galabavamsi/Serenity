import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class JigsawPuzzleGame extends StatefulWidget {
  const JigsawPuzzleGame({super.key});

  @override
  _JigsawPuzzleGameState createState() => _JigsawPuzzleGameState();
}

class _JigsawPuzzleGameState extends State<JigsawPuzzleGame> {
  List<Widget> puzzlePieces = [];
  List<Offset> piecePositions = [];
  List<Offset> targetPositions = [];
  int gridSize = 3; // 3x3 grid
  int score = 0;
  int timeLeft = 60; // 60 seconds timer
  Timer? gameTimer;
  AudioPlayer audioPlayer = AudioPlayer(); // For sound effects
  int hintIndex = -1; // Index of the piece to show hint for

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
    _startGameTimer();
  }

  void _initializePuzzle() {
    // Initialize puzzle pieces and positions
    for (int i = 0; i < gridSize * gridSize; i++) {
      puzzlePieces.add(Container(
        decoration: BoxDecoration(
          color: Colors.primaries[i % Colors.primaries.length],
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$i',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ));
      piecePositions.add(Offset(i % gridSize * 100.0, i ~/ gridSize * 100.0));
      targetPositions.add(Offset(i % gridSize * 100.0, i ~/ gridSize * 100.0));
    }
    puzzlePieces.shuffle();
  }

  void _startGameTimer() {
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        _showGameOverDialog();
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score: $score\nTime's up!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      score = 0;
      timeLeft = 60;
      puzzlePieces.clear();
      piecePositions.clear();
      targetPositions.clear();
      hintIndex = -1;
      _initializePuzzle();
      _startGameTimer();
    });
  }

  void _checkPiecePosition(int index, Offset newPosition) {
    if ((newPosition - targetPositions[index]).distance < 20.0) {
      setState(() {
        piecePositions[index] = targetPositions[index];
        score += 1;
        _playSound('bubble.mp3'); // Play sound when piece is correctly placed
      });
    } else {
      setState(() {
        piecePositions[index] = newPosition;
      });
    }
  }

  void _playSound(String soundFile) async {
    try {
      await audioPlayer.play(AssetSource('images/$soundFile'));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  void _showHint() {
    setState(() {
      hintIndex = (hintIndex + 1) % puzzlePieces.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jigsaw Puzzle Game'),
        backgroundColor: Colors.pink.shade50,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: _showHint,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Drag and drop the pieces to their correct positions. Use the hint button if you need help.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: puzzlePieces.length,
              itemBuilder: (context, index) {
                return Draggable(
                  data: index,
                  feedback: puzzlePieces[index],
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    _checkPiecePosition(index, details.offset);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: hintIndex == index ? Colors.red : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: puzzlePieces[index],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Time Left: $timeLeft',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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