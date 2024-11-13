import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Custom_widgets/custom_textfield.dart';
import 'package:serenity_app/Screens/first_screen.dart';
import 'package:serenity_app/provider/StressCalculator.dart';
import 'package:serenity_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'Screens/welcome_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAzpq5o-WIAXd4jKXlEbsHRDCI4Z3SNXBA",
        appId: "1:635298080845:web:1cb5105b2d1cd745319404",
        messagingSenderId: "635298080845",
        projectId: "serenity-4f016",
      ),
    );
  } else if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StressCalculator(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serenity',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}

// Log In Screen with Firebase Sign In
class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseUserAuth _auth = FirebaseUserAuth();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'All fields must be filled';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Call Firebase sign-in method
    final result = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isLoading = false;
      _errorMessage = result;
    });

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.pink.shade50,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.pink.shade200,
                      child: Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.pink.shade50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 40, fontFamily: 'SecondFont'),
                    ),
                    const SizedBox(height: 20),
                    // Email input field
                    CustomTextfield(
                      controller: _emailController,
                      hintText: 'Enter your email',
                    ),
                    const SizedBox(height: 20),
                    // Password input field
                    CustomTextfield(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 10),
                    // Sign In Button
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signIn,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : const Text(
                          'Sign In',
                          style:
                          TextStyle(fontSize: 20, fontFamily: 'SecondFont'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
