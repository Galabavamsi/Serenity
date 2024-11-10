import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomListTile extends StatelessWidget{



  const CustomListTile({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth*0.85,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: const ListTile(
        leading: FaIcon(
          FontAwesomeIcons.faceSmile,
          size: 48,
        ),
        title: Text('Date: 1/11/24',style: TextStyle(
            fontSize: 24,
            fontFamily: 'SecondFont'
        ),),
        subtitle: Text('Title',style: TextStyle(
            fontFamily: 'SecondFont'
        ),),

      ),
    );
  }

}
