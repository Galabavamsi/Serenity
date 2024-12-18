import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:serenity_app/Screens/exercise/exercise.dart'; // Import the ExerciseScreen
import 'package:workmanager/workmanager.dart';

class ExerciseTimerScreen extends StatefulWidget {
  const ExerciseTimerScreen({super.key});

  @override
  _ExerciseTimerScreenState createState() => _ExerciseTimerScreenState();
}

class _ExerciseTimerScreenState extends State<ExerciseTimerScreen> {
  Duration _duration = const Duration();
  Duration _remainingDuration = const Duration();
  bool _isRunning = false;
  bool _isPaused = false;
  late FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  void _initializeNotifications() {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    _localNotificationsPlugin.initialize(initializationSettings);
  }

  void _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'exercise_timer_channel',
      'Exercise Timer',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _localNotificationsPlugin.show(
      0,
      'Exercise Timer',
      'Your exercise timer is complete!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingDuration.inSeconds > 0) {
          _remainingDuration = _remainingDuration - const Duration(seconds: 1);
        } else {
          timer.cancel();
          _isRunning = false;
          _showNotification();
        }
      });
    });
    Workmanager().registerOneOffTask(
      '1',
      'exerciseTimerTask',
      inputData: {'duration': _remainingDuration.inSeconds > 0 ? _remainingDuration.inSeconds : _duration.inSeconds},
      initialDelay: _remainingDuration.inSeconds > 0 ? _remainingDuration : _duration,
    );
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
    _countdownTimer?.cancel();
    Workmanager().cancelAll();
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _remainingDuration = const Duration();
    });
    _countdownTimer?.cancel();
    Workmanager().cancelAll();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _remainingDuration = _duration;
    });
    _countdownTimer?.cancel();
    Workmanager().cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Timer'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ExerciseScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _duration = Duration(hours: time.hour, minutes: time.minute);
                    _remainingDuration = _duration;
                  });
                }
              },
              child: const Text('Set Timer'),
            ),
            const SizedBox(height: 20),
            Text(
              'Duration: ${_duration.inHours}h ${_duration.inMinutes % 60}m',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Remaining: ${_remainingDuration.inHours}h ${_remainingDuration.inMinutes % 60}m ${_remainingDuration.inSeconds % 60}s',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? null : _startTimer,
              child: const Text('Start Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning && !_isPaused ? _pauseTimer : null,
              child: const Text('Pause Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? _stopTimer : null,
              child: const Text('Stop Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetTimer,
              child: const Text('Reset Timer'),
            ),
          ],
        ),
      ),
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    final duration = inputData!['duration'] as int;
    Future.delayed(Duration(seconds: duration), () {
      FlutterRingtonePlayer().playNotification();
      // Show notification
      FlutterLocalNotificationsPlugin().show(
        0,
        'Exercise Timer',
        'Your exercise timer is complete!',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'exercise_timer_channel',
            'Exercise Timer',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
        ),
      );
    });
    return Future.value(true);
  });
}