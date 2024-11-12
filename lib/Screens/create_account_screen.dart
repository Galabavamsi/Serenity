import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/first_screen.dart';
import 'package:serenity_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../Custom_widgets/custom_textfield.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseUserAuth _auth = FirebaseUserAuth();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signUp() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Basic validation
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'All fields must be filled';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Attempt sign-up
    final result = await _auth.signUpWithEmailAndPassword(email, password, username);

    setState(() {
      _isLoading = false;
      _errorMessage = result;
    });

    if (result == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.pink.shade50,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.pink.shade200,
                      child: Icon(Icons.person, size: 120, color: Colors.pink.shade50),
                    ),
                    const SizedBox(height: 20),
                    const Text('Create Account', style: TextStyle(fontSize: 40, fontFamily: 'SecondFont')),
                    const SizedBox(height: 20),
                    CustomTextfield(controller: _usernameController, hintText: 'Username'),
                    const SizedBox(height: 20),
                    CustomTextfield(controller: _emailController, hintText: 'Email'),
                    const SizedBox(height: 20),
                    CustomTextfield(controller: _passwordController, hintText: 'Create a password', obscureText: true),
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        child: _isLoading ? CircularProgressIndicator() : Text('Create account', style: TextStyle(fontSize: 20, fontFamily: 'SecondFont')),
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
