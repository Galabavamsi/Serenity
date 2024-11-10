import 'package:flutter/material.dart';

class CallExpert extends StatelessWidget{
  const CallExpert({super.key});


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text('Call an Expert',style: TextStyle(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dr.Gajanand',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 24
                    ),),
                    Text('94079005XX',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 20
                    ),),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dr.X',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 24
                    ),),
                    Text('94079005XX',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 20
                    ),),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dr.Y',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 24
                    ),),
                    Text('94079005XX',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 20
                    ),),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dr.Z',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 24
                    ),),
                    Text('94079005XX',style: TextStyle(
                        fontFamily:'SecondFont',
                        fontSize: 20
                    ),),
                  ],
                ),
                SizedBox(height: screenHeight*0.02,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}