import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/home_screen.dart';
import 'package:serenity_app/Screens/exercise/exercise_timer.dart'; // Import the exercise timer screen
import 'package:serenity_app/Screens/exercise/meditation_timer.dart'; // Import the meditation timer screen
import 'package:serenity_app/Screens/exercise/steps_count.dart'; // Import the steps count screen

class ExerciseScreen extends StatelessWidget {
const ExerciseScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Exercise'),
backgroundColor: Colors.purple,
leading: IconButton(
icon: const Icon(Icons.arrow_back),
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) => const HomeScreen()),
);
},
),
),
body: Container(
decoration: BoxDecoration(
gradient: LinearGradient(
colors: [Colors.pink.shade50, Colors.purple.shade50],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
FeatureCard(
icon: Icons.timer,
title: 'Exercise Timer',
description: 'Track your exercise duration.',
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const ExerciseTimerScreen()),
);
},
),
FeatureCard(
icon: Icons.self_improvement,
title: 'Meditation Timer',
description: 'Track your meditation sessions.',
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const MeditationTimerScreen()),
);
},
),
FeatureCard(
icon: Icons.directions_walk,
title: 'Yoga Exercises',
description: 'Practice various yogic exercises.',
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const YogaExercisesScreen()),
);
},
),
],
),
),
),
);
}
}

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