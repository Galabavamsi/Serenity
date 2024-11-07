import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaceTracking extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: Text('Know your Mood',style: TextStyle(
            fontFamily: 'SecondFont'
        ),),
      ),
      body: Container(
        color: Colors.pink.shade50,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: screenWidth*0.9,
            height: screenHeight*0.9,
            decoration: BoxDecoration(
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
            child: Center(child: Text('Face tracker here',style: TextStyle(
              fontSize:40,
            ),)),
          ),
        ),
      ),
    );
  }

}