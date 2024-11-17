import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class FaceTracking extends StatefulWidget {
  const FaceTracking({super.key});

  @override
  State<FaceTracking> createState() => _FaceTrackingState();
}

class _FaceTrackingState extends State<FaceTracking> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _guidelineShown = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final cameras = await availableCameras();
      // Select the front camera if available
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // Fallback to the first camera if front is not found
      );

      _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
      await _cameraController?.initialize();
      setState(() {
        _isCameraInitialized = true;
      });

      // Show guidelines after the camera is initialized
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _guidelineShown = true;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission denied'),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text(
          'Know Your Mood',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: Stack(
        children: [
          if (_isCameraInitialized)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Add rounded corners
                child: AspectRatio(
                  aspectRatio: 3 / 4, // Set the aspect ratio to 3:4
                  child: CameraPreview(_cameraController!),
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_guidelineShown) _buildGuidelineOverlay(),
        ],
      ),
    );
  }

  Widget _buildGuidelineOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Smile for 10 seconds!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'SecondFont',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSmileMessage();
              },
              child: const Text("Start Smiling!"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSmileMessage() async {
    setState(() {
      _guidelineShown = false;
    });

    await Future.delayed(const Duration(seconds: 10), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('See how beautiful you look when you smile!'),
          content: const Text(
            'Smiling releases endorphins, which make you feel happier and less stressed!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to Home Screen
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      );
    });
  }
}