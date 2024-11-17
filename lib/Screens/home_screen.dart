import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/call_an_expert/call_expert.dart';
import 'package:serenity_app/Screens/habits/habits.dart';
import 'package:serenity_app/Screens/know_your_mood/face_tracking_screen.dart';
import 'package:serenity_app/Screens/know_your_stress_score/question_1_screen.dart';
import 'package:serenity_app/Screens/self_care/self_care.dart';
import 'package:serenity_app/Screens/chatbot_screen.dart';
import 'package:audioplayers/audioplayers.dart';

// HomeScreen Class
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 18) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background with Parallax Effect
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          // Gradient Overlay for Text Visibility
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        getGreeting(),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Welcome back to Serenity. Let's make today amazing!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Feature Cards
                FeatureCard(
                  icon: Icons.self_improvement,
                  title: "Know Your Stress Score",
                  description:
                      "Analyze your stress level and get actionable insights.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Question1()),
                    );
                  },
                ),
                FeatureCard(
                  icon: Icons.mood,
                  title: "Know Your Mood",
                  description:
                      "Track your mood and understand your feelings better.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FaceTracking()),
                    );
                  },
                ),
                FeatureCard(
                  icon: Icons.repeat,
                  title: "Habits",
                  description:
                      "Build healthy habits that stick with you for life.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Habits()),
                    );
                  },
                ),
                FeatureCard(
                  icon: Icons.spa,
                  title: "Self Care",
                  description:
                      "Discover self-care practices tailored to your needs.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelfCare()),
                    );
                  },
                ),
                FeatureCard(
                  icon: Icons.phone,
                  title: "Call An Expert",
                  description:
                      "Talk to mental health experts for personalized advice.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CallExpert()),
                    );
                  },
                ),
                // New Feature Cards for Timers
                FeatureCard(
                  icon: Icons.access_alarm,
                  title: "Meditation Timer",
                  description:
                      "Start your meditation session with a relaxing timer.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MeditationTimerScreen()),
                    );
                  },
                ),
                FeatureCard(
                  icon: Icons.fitness_center,
                  title: "Exercise Timer",
                  description:
                      "Set your exercise intervals and track progress.",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExerciseTimerScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      // Floating Chatbot Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotScreen()),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}

// Feature Card Widget
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple.withOpacity(0.1),
              radius: 30,
              child: Icon(icon, color: Colors.purple, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Meditation Timer Screen
class MeditationTimerScreen extends StatefulWidget {
  const MeditationTimerScreen({super.key});

  @override
  _MeditationTimerScreenState createState() => _MeditationTimerScreenState();
}

class _MeditationTimerScreenState extends State<MeditationTimerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _minutes = 5; // Default meditation time
  bool _isTimerRunning = false;
  late Duration _duration;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();
    _duration = Duration(minutes: _minutes);
    _remainingTime = _minutes * 60; // Remaining time in seconds
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });

    // Countdown timer
    Future.delayed(Duration(seconds: 1), () {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      } else {
        _audioPlayer.play(
            AssetSource('images/relax.mp3')); // Play bell sound when timer ends
        setState(() {
          _isTimerRunning = false;
        });
      }
      _audioPlayer.play(AssetSource('images/relax.mp3'));
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsLeft = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meditation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Meditation ",
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            Text(_formatTime(_remainingTime),
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isTimerRunning ? null : _startTimer,
              child:
                  Text(_isTimerRunning ? "Timer Running" : "Start Meditation"),
            ),
            SizedBox(height: 20),
            // Slider to change the meditation time
            Slider(
              value: _minutes.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: "$_minutes min",
              onChanged: (newValue) {
                setState(() {
                  _minutes = newValue.toInt();
                  _duration = Duration(minutes: _minutes);
                  _remainingTime = _minutes * 60; // Reset the remaining time
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Exercise Timer Screen
class ExerciseTimerScreen extends StatefulWidget {
  const ExerciseTimerScreen({super.key});

  @override
  _ExerciseTimerScreenState createState() => _ExerciseTimerScreenState();
}

class _ExerciseTimerScreenState extends State<ExerciseTimerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _exerciseTime = 30; // Default exercise time
  int _restTime = 15; // Default rest time
  bool _isTimerRunning = false;
  late Duration _exerciseDuration;
  late Duration _restDuration;
  late int _remainingExerciseTime;
  late int _remainingRestTime;

  @override
  void initState() {
    super.initState();
    _exerciseDuration = Duration(seconds: _exerciseTime);
    _restDuration = Duration(seconds: _restTime);
    _remainingExerciseTime = _exerciseTime;
    _remainingRestTime = _restTime;
  }

  void _startExercise() {
    setState(() {
      _isTimerRunning = true;
    });

    // Exercise timer countdown
    Future.delayed(Duration(seconds: 1), () {
      if (_remainingExerciseTime > 0) {
        setState(() {
          _remainingExerciseTime--;
        });
        _startExercise();
      } else {
        _audioPlayer.play(AssetSource('images/realx.mp3')); // Interval sound

        // Rest timer countdown
        Future.delayed(Duration(seconds: 1), () {
          if (_remainingRestTime > 0) {
            setState(() {
              _remainingRestTime--;
            });
            _startExercise();
          } else {
            _audioPlayer.play(AssetSource('images/relax.mp3')); // Rest sound
            setState(() {
              _isTimerRunning = false;
            });
          }
        });
      }
      _audioPlayer.play(AssetSource('images/relax.mp3'));
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsLeft = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Exercise", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            Text("Exercise: ${_formatTime(_remainingExerciseTime)}",
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text("Rest: ${_formatTime(_remainingRestTime)}",
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isTimerRunning ? null : _startExercise,
              child: Text(_isTimerRunning ? "Timer Running" : "Start Exercise"),
            ),
            SizedBox(height: 20),
            // Sliders to adjust exercise and rest times
            Slider(
              value: _exerciseTime.toDouble(),
              min: 10,
              max: 180,
              divisions: 17,
              label: "$_exerciseTime sec",
              onChanged: (newValue) {
                setState(() {
                  _exerciseTime = newValue.toInt();
                  _exerciseDuration = Duration(seconds: _exerciseTime);
                  _remainingExerciseTime = _exerciseTime; // Reset
                });
              },
            ),
            Slider(
              value: _restTime.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              label: "$_restTime sec",
              onChanged: (newValue) {
                setState(() {
                  _restTime = newValue.toInt();
                  _restDuration = Duration(seconds: _restTime);
                  _remainingRestTime = _restTime; // Reset
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
