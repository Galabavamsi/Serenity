import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/first_screen.dart';
import '../Custom_widgets/custom_textfield.dart';

class create_account extends StatelessWidget{

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();

  create_account({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                const SizedBox(height: 20,),
                const Text('Create Account',style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'SecondFont',

                ),),
                const SizedBox(height: 20,),
                CustomTextfield(Controller: nameController, hintText: 'Name'),
                const SizedBox(height: 20,),
                CustomTextfield(Controller: ageController, hintText: 'Enter your age'),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 280,
                  child: TextField(
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      hintText: 'Create a password',
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',

                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return const first_screen();
                    }));
                  },
                      child: const Text('Create account',style: TextStyle(
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



