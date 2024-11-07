import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Habits extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: Text('Habits',style: TextStyle(
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
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Stress Reducing Habits',style: TextStyle(
                    fontSize: 29,
                    fontFamily: 'ThirdFont',
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: screenHeight*0.03,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.running,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Sports & Physical activity',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.spa,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Mindfullness Meditation',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.clock,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Time Management',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.bed,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Sleep',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.book,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Journaling',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.heart,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Gratitude',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
                SizedBox(height: screenHeight*0.01,),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.tree,
                    color: Colors.green,
                    size: 25,
                  ),
                  title: Text('Time in Nature',style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'ThirdFont'
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}