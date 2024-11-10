import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Custom_widgets/custom_outlinedButton.dart';
import 'package:serenity_app/Custom_widgets/custom_valueButton.dart';
import 'package:serenity_app/Screens/know_your_stress_score/question_2.dart';
import 'package:serenity_app/provider/StressCalculator.dart';


class Question1 extends StatelessWidget{
  const Question1({super.key});


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //Parameters

    int totalValue = Provider.of<StressCalculator>(context).totalValue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: const Text('Know your Stress Score',style: TextStyle(
            fontFamily: 'SecondFont'
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child:Container(
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
                  Container(
                    child: const Text('Question 1',style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'SecondFont'
                    ),),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  const Text('How often do you feel overwhelmed by daily tasks or responsibilities?',
                    style: TextStyle(
                      fontFamily: 'ThirdFont',
                      fontSize: 23,
                  ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  CustomValueButton(onPressed: (){
                    Provider.of<StressCalculator>(context,listen: false).addRating(1);
                  }, text: 'Never'),
                  SizedBox(height: screenHeight*0.02,),
                  CustomValueButton(onPressed: (){
                    Provider.of<StressCalculator>(context,listen: false).addRating(2);
                  }, text: 'Rarely'),
                  SizedBox(height: screenHeight*0.02,),
                  CustomValueButton(onPressed: (){
                    Provider.of<StressCalculator>(context,listen: false).addRating(3);
                  }, text: 'Sometimes'),
                  SizedBox(height: screenHeight*0.02,),
                  CustomValueButton(onPressed: (){
                    Provider.of<StressCalculator>(context,listen: false).addRating(4);
                  }, text: 'Often'),
                  SizedBox(height: screenHeight*0.02,),
                  CustomValueButton(onPressed: (){
                    Provider.of<StressCalculator>(context,listen: false).addRating(5);
                  }, text: 'Always'),
                  SizedBox(height: screenHeight*0.02,),
                  CustomOutlinedButton(onPressed: (){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Question2()));                  }, data: 'Next')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
