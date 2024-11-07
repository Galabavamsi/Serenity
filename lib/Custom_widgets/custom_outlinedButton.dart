import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String data;

  const CustomOutlinedButton({Key?key,
    required this.onPressed,
    required this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth*0.8,
        height: screenHeight*0.06,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.pink.shade200,
          borderRadius: BorderRadius.circular(25)
        ),
        child: OutlinedButton(onPressed: onPressed, child:Text(data,style: TextStyle(
            fontSize: 20,
            fontFamily: 'SecondFont'
        ),))
    );
  }
}
