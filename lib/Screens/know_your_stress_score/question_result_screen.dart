import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Custom_widgets/custom_outlinedButton.dart';
import 'package:serenity_app/Screens/home_screen.dart';
import 'package:serenity_app/provider/StressCalculator.dart';

class Result extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double top = screenHeight*0.3;
    double left = screenWidth*0;

    //Provider
    int totalValue = Provider.of<StressCalculator>(context).totalValue;

    // If loop for Stress calculation
    String stressRange;
    if(totalValue <= 9 && totalValue >= 5){
      stressRange = 'Low Stress';
    } else if(totalValue >= 10 && totalValue <= 14){
      stressRange = 'Moderate Stress';
    } else if(totalValue >= 15 && totalValue <= 19){
      stressRange = 'High Stress';
    } else if(totalValue >= 20 && totalValue <= 25){
      stressRange = 'Very High Stress';
    } else{
      stressRange = 'Please enter the valid input';
    }


    return WillPopScope(
      onWillPop: () async{
        Provider.of<StressCalculator>(context,listen: false).resetValue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade50,
          title: Text('Know your Stress Score',style: TextStyle(
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

                  children: [
                    Container(
                      margin:  EdgeInsets.only(top: top,left: left),
                      child: Text('Result',style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'SecondFont'
                      ),),
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Text('Stress range : $stressRange',style: TextStyle(
                        fontFamily: 'ThirdFont',
                        fontSize: 27,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight*0.02,),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

}