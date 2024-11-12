import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/Custom_Button.dart';
import 'package:serenity_app/Custom_widgets/custom_textfield.dart';
import 'package:serenity_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:serenity_app/Screens/welcome_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseUserAuth _auth = FirebaseUserAuth();

  String? currentUsername = "Current Username"; // placeholder for current username

  @override
  void initState() {
    super.initState();
    _usernameController.text = currentUsername ?? '';
    _passwordController.text = ''; // Don't pre-fill the password for security
  }

  Future<void> _updateUsername() async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username cannot be empty.")),
      );
      return;
    }

    String? result = await _auth.updateUsername(_usernameController.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username updated successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  Future<void> _updatePassword() async {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password cannot be empty.")),
      );
      return;
    }

    String? result = await _auth.updatePassword(_passwordController.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  Future<void> _deleteAccount() async {
    String? result = await _auth.deleteAccount();
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account deleted successfully.")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
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
                  CustomTextfield(
                    controller: _usernameController,
                    hintText: 'Enter new username',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Update Username',
                    onPressed: _updateUsername,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: _passwordController,
                    hintText: 'Enter new password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Update Password',
                    onPressed: _updatePassword,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Delete Account',
                    onPressed: _deleteAccount,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
