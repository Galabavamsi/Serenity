import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/custom_outlinedButton.dart';
import 'package:serenity_app/Screens/edit_profile_screen.dart'; // Import the Edit Profile Screen
import 'package:serenity_app/Screens/welcome_screen.dart'; // Import the Welcome Screen
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Log out method
    Future<void> logout() async {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: screenWidth * 0.9,
              height: screenHeight * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Shadow color
                    blurRadius: 20, // Softening the shadow
                    offset: Offset(0, 5), // Positioning the shadow
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
                  // Edit Profile Button
                  CustomOutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    data: 'Edit Profile',
                  ),
                  const SizedBox(height: 10),
                  // Stress Analysis Button
                  CustomOutlinedButton(
                    onPressed: () {
                      // Handle Stress Analysis functionality here
                    },
                    data: 'Stress Analysis',
                  ),
                  const SizedBox(height: 10),
                  // Log Out Button
                  CustomOutlinedButton(
                    onPressed: logout, // Trigger the log out method
                    data: 'Log Out',
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
