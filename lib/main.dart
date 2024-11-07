import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity_app/Custom_widgets/custom_textfield.dart';
import 'package:serenity_app/Screens/first_screen.dart';
import 'package:serenity_app/provider/StressCalculator.dart';


import 'Screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> StressCalculator(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serenity',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: welcome_screen(),
      ),
    );
  }
}
// Log In Screen
class logIn_screen extends StatelessWidget{

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.pink.shade50,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
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
                SizedBox(height: 20,),
                Text('Sign In',style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'SecondFont',

                ),),
                SizedBox(height: 20,),
                CustomTextfield(Controller: nameController, hintText: 'Enter your name'),
                SizedBox(height: 20,),
                Container(
                  width: 280,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Enter password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',

                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 150,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return first_screen();
                    }));
                  }, child: Text('Sign In',style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SecondFont'
                  ),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}
