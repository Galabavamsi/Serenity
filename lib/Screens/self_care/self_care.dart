import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/custom_outlinedButton.dart';
import 'package:serenity_app/Screens/game/game_screen.dart';

class SelfCare extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: Text('Self Care',style: TextStyle(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('"Feeling stressed? Take a break and relax with a calming game designed to ease your mind and lift your spirits"',
                    style: TextStyle(
                    fontFamily: 'SecondFont',
                      fontSize: 25
                  ),
                  textAlign: TextAlign.center,),
                ),
                SizedBox(height: screenHeight*0.05,),
                CustomOutlinedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return BubblePopGameScreen();
                  }));
                }, data: 'Start a game',),
              ],
            ),
          ),
        ),
      ),
    );
  }

}