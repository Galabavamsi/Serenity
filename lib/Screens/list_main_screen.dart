// This is the list or diary screen

import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/custom_ListTile.dart';

class ListScreen extends StatelessWidget{
  const ListScreen({super.key});



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text('List',style: TextStyle(
            fontFamily: 'SecondFont'
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child:Container(
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomListTile(),
                  CustomListTile(),
                  CustomListTile(),
                  CustomListTile(),
        
                ],
              ),
        
            ),
          ),
        ),
      ),
    );
  }

}
