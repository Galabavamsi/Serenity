// This is the profile screen

import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/custom_outlinedButton.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text('Profile',style: TextStyle(
            fontFamily: 'SecondFont'
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top:50),
              width: screenWidth*0.9,
              height: screenHeight*0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Shadow color
                    blurRadius: 20, // Softening the shadow
                    offset: Offset(0, 5), // Positioning the shadow
                  ),
                ],
              ),
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.pink.shade200,
                      child: Icon(Icons.person,
                        size: 120,
                        color: Colors.pink.shade50,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CustomOutlinedButton(onPressed: (){}, data: 'Edit Profile',),
                    CustomOutlinedButton(onPressed: (){}, data: 'Stress Analysis',),
                    CustomOutlinedButton(onPressed: (){}, data: 'Log Out',),
                  ]
        
              ),
            ),
          ),
        ),
      ),
    );
  }

}