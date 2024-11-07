import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenity_app/Custom_widgets/Custom_Button.dart';
import 'package:serenity_app/Screens/create_account_screen.dart';
import 'package:serenity_app/main.dart';

class welcome_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color:  Colors.pink.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text( 'Welcome to our app!',style: TextStyle(
                    fontFamily: 'SecondFont',
                    fontSize: 40
                ),),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/serenity_logo.png"),)
                    ),
                  )
                ],
              ),
              SizedBox(height: 75,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(text: 'Create account', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return create_account();
                    }));
                  }),
                  SizedBox(width:10,),
                  CustomButton(text: 'Sign in', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return logIn_screen();
                    }));
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}