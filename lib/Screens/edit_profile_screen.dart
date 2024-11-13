import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/custom_textfield.dart';
import 'package:serenity_app/Custom_widgets/Custom_Button.dart';
import 'package:serenity_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:serenity_app/Screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _currentPasswordController = TextEditingController();  // Controller for current password
  final FirebaseUserAuth _auth = FirebaseUserAuth();

  String? currentUsername = ""; // Placeholder for the current username

  @override
  void initState() {
    super.initState();
    _loadCurrentUsername();
  }

  // Fetch the current username when the screen loads
  Future<void> _loadCurrentUsername() async {
    String? username = await _auth.getCurrentUsername();
    setState(() {
      currentUsername = username; // Set the username fetched from Firestore
      _usernameController.text = currentUsername ?? ''; // Set the controller text
    });
  }

  Future<void> _updateUsername() async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username cannot be empty.")),
      );
      return;
    }

    // Check if the new username is the same as the current username
    if (_usernameController.text == currentUsername) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username is the same, no update made.")),
      );
      return;
    }

    String currentPassword = _currentPasswordController.text;

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your current password.")),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;

    // Re-authenticate with the current password
    AuthCredential credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    try {
      // Re-authenticate
      await user.reauthenticateWithCredential(credential);

      // Proceed with username update
      String? result = await _auth.updateUsername(_usernameController.text, currentPassword);
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username updated successfully.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current password is incorrect.")),
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

    String currentPassword = _currentPasswordController.text;

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your current password.")),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;

    // Re-authenticate with the current password
    AuthCredential credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    try {
      // Re-authenticate
      await user.reauthenticateWithCredential(credential);

      // Check if the new password is the same as the current password
      if (_passwordController.text == currentPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("New password cannot be the same as the current password.")),
        );
        return;
      }

      // Proceed with password update
      String? result = await _auth.updatePassword(_passwordController.text, currentPassword);
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current password is incorrect.")),
      );
    }
  }

  Future<void> _confirmAndDeleteAccount() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Account Deletion"),
          content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // User pressed Cancel
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // User pressed Confirm
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
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
                  // Username Update
                  CustomTextfield(
                    controller: _usernameController,
                    hintText: currentUsername ?? 'Enter new username', // Use current username or default placeholder
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Update Username',
                    onPressed: _updateUsername,
                  ),
                  const SizedBox(height: 20),
                  // Current Password Input
                  CustomTextfield(
                    controller: _currentPasswordController,
                    hintText: 'Enter current password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Password Update
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
                    onPressed: _confirmAndDeleteAccount,
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
