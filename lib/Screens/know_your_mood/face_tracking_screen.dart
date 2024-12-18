import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class MoodDetectionScreen extends StatefulWidget {
  const MoodDetectionScreen({super.key});

  @override
  _MoodDetectionScreenState createState() => _MoodDetectionScreenState();
}

class _MoodDetectionScreenState extends State<MoodDetectionScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isDetecting = false;
  String _mood = "Unknown";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadModel();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  void _loadModel() async {
    await Tflite.loadModel(
      model: "assets/face_detection.tflite",
      labels: "assets/face_labels.txt",
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  void _startMoodDetection() {
    if (_isDetecting) return;

    _isDetecting = true;
    _cameraController.startImageStream((CameraImage image) async {
      try {
        var recognitions = await Tflite.runModelOnFrame(
          bytesList: image.planes.map((plane) => plane.bytes).toList(),
          imageHeight: image.height,
          imageWidth: image.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.5,
        );

        if (recognitions != null && recognitions.isNotEmpty) {
          final mood = await _detectMood();
          setState(() {
            _mood = mood;
          });
        }
      } catch (e) {
        print("Error detecting faces: $e");
      }
    });
  }

  Future<String> _detectMood() async {
    // Example logic to determine mood based on face detection results
    // This should be replaced with actual mood detection logic
    return "Happy";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Detection')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(child: CameraPreview(_cameraController)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Detected Mood: $_mood', style: TextStyle(fontSize: 24)),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startMoodDetection,
        child: Icon(Icons.camera),
      ),
    );
  }
}