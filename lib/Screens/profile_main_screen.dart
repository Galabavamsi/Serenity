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
        backgroundColor: Colors.pink.shade100,
        elevation: 4.0,
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'SecondFont', fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // Use background image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'), // Make sure this path matches your assets directory
              fit: BoxFit.cover, // Make sure the image covers the screen
              alignment: Alignment.center,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: screenWidth * 0.9,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.8), Colors.pink.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture with Elevated Border
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('images/main_image.jpg'), // Placeholder image
                    backgroundColor: Colors.pink.shade200,
                  ),
                  const SizedBox(height: 20),

                  // User Info (Name, Email) - Optional, add based on the user info stored
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'User Name', // Add dynamic username here
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'useremail@example.com', // Add dynamic user email here
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.pink.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Edit Profile Button with ElevatedStyle
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
                  const SizedBox(height: 20),

                  // Stress Analysis Button
                  CustomOutlinedButton(
                    onPressed: () {
                      // Handle Stress Analysis functionality here
                    },
                    data: 'Stress Analysis',
                  ),
                  const SizedBox(height: 20),

                  // Log Out Button with ElevatedStyle
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
