import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(HabitsApp());

class HabitsApp extends StatelessWidget {
  const HabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits App',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Habits(),
    );
  }
}

class Habits extends StatelessWidget {
  const Habits({super.key});

  void navigateToDetail(BuildContext context, String habit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitDetails(habitName: habit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Habits',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(15),
          children: habitList.map((habit) {
            return _buildHabitTile(
              context,
              habit.name,
              habit.icon,
              () => navigateToDetail(context, habit.name),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHabitTile(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: FaIcon(icon, color: Colors.green, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

class HabitDetails extends StatefulWidget {
  final String habitName;

  const HabitDetails({super.key, required this.habitName});

  @override
  _HabitDetailsState createState() => _HabitDetailsState();
}

class _HabitDetailsState extends State<HabitDetails> {
  late Habit habit;
  int completedTipsCount = 0;
  bool isReminderSet = false;

  @override
  void initState() {
    super.initState();
    habit = habitList.firstWhere((h) => h.name == widget.habitName);
  }

  void _updateProgress(double newProgress) {
    setState(() {
      habit.progress = newProgress;
    });
  }

  void _setReminder() {
    setState(() {
      isReminderSet = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder set for ${habit.name}!')),
    );
  }

  void _markTipAsComplete(int index) {
    setState(() {
      completedTipsCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You completed a tip!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildProgressBar(habit),
            SizedBox(height: 20),
            Text(
              'Benefits:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            ...habit.benefits.map((benefit) => ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(benefit),
                )),
            SizedBox(height: 20),
            Text(
              'Tips to Get Started:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            ...habit.tips.map((tip) {
              int index = habit.tips.indexOf(tip);
              return ListTile(
                leading: Icon(
                  completedTipsCount > index
                      ? Icons.check_circle
                      : Icons.lightbulb,
                  color: completedTipsCount > index
                      ? Colors.green
                      : Colors.yellow[700],
                ),
                title: Text(tip),
                onTap: () => _markTipAsComplete(index),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setReminder,
              child: Text(isReminderSet ? 'Reminder Set!' : 'Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressBar(Habit habit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Progress:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: habit.progress,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
        ),
        SizedBox(height: 10),
        Text('${(habit.progress * 100).toStringAsFixed(1)}% completed'),
        SizedBox(height: 10),
        Slider(
          value: habit.progress,
          min: 0.0,
          max: 1.0,
          onChanged: _updateProgress,
        ),
      ],
    );
  }
}

class Habit {
  final String name;
  final String description;
  final List<String> benefits;
  final List<String> tips;
  final IconData icon;
  double progress;

  Habit({
    required this.name,
    required this.description,
    required this.benefits,
    required this.tips,
    required this.icon,
    required this.progress,
  });
}

final List<Habit> habitList = [
  Habit(
    name: 'Sports & Physical Activity',
    description:
        'Engage in regular exercise to boost physical and mental health.',
    benefits: [
      'Improves cardiovascular health',
      'Reduces stress',
      'Increases energy'
    ],
    tips: [
      'Start with 30 minutes a day',
      'Join a local sports team',
      'Mix strength and cardio workouts'
    ],
    icon: FontAwesomeIcons.running,
    progress: 0.6,
  ),
  Habit(
    name: 'Mindfulness Meditation',
    description: 'Practice mindfulness to achieve a calm and focused mind.',
    benefits: ['Reduces anxiety', 'Improves focus', 'Enhances self-awareness'],
    tips: [
      'Begin with 5-minute sessions',
      'Use guided meditation apps',
      'Create a distraction-free environment'
    ],
    icon: FontAwesomeIcons.spa,
    progress: 0.4,
  ),
  Habit(
    name: 'Time Management',
    description: 'Master time management to improve productivity and balance.',
    benefits: [
      'Increases productivity',
      'Reduces procrastination',
      'Improves life balance'
    ],
    tips: [
      'Use a planner or app',
      'Set realistic deadlines',
      'Break tasks into smaller steps'
    ],
    icon: FontAwesomeIcons.clock,
    progress: 0.3,
  ),
  Habit(
    name: 'Sleep',
    description: 'Prioritize sleep to recharge your body and mind.',
    benefits: ['Improves concentration', 'Boosts immunity', 'Enhances mood'],
    tips: [
      'Maintain a consistent sleep schedule',
      'Avoid screens before bed',
      'Create a relaxing bedtime routine'
    ],
    icon: FontAwesomeIcons.bed,
    progress: 0.8,
  ),
  Habit(
    name: 'Journaling',
    description: 'Write daily to clear your mind and set goals.',
    benefits: [
      'Boosts creativity',
      'Enhances self-reflection',
      'Reduces mental clutter'
    ],
    tips: [
      'Write for 10 minutes each day',
      'Use prompts for inspiration',
      'Be honest and consistent'
    ],
    icon: FontAwesomeIcons.book,
    progress: 0.7,
  ),
  Habit(
    name: 'Gratitude',
    description: 'Practice gratitude to cultivate positivity.',
    benefits: [
      'Increases happiness',
      'Reduces stress',
      'Improves relationships'
    ],
    tips: [
      'Write down 3 things you are grateful for daily',
      'Express gratitude to others',
      'Reflect on positive experiences'
    ],
    icon: FontAwesomeIcons.heart,
    progress: 0.5,
  ),
  Habit(
    name: 'Time in Nature',
    description: 'Spend time outdoors to reconnect with the natural world.',
    benefits: [
      'Improves mental health',
      'Boosts physical well-being',
      'Enhances creativity'
    ],
    tips: [
      'Take a daily walk in a park',
      'Try outdoor activities like hiking',
      'Incorporate greenery into your workspace'
    ],
    icon: FontAwesomeIcons.tree,
    progress: 0.65,
  ),
];
