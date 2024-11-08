// This is the first screen after the create or sign in screen.In this there is logic of bottom navigation bar

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenity_app/Screens/home_screen.dart';
import 'package:serenity_app/Screens/list_main_screen.dart';
import 'package:serenity_app/Screens/profile_main_screen.dart';

class first_screen extends StatefulWidget{

  @override
  State<first_screen> createState() => _first_screenState();
}

class _first_screenState extends State<first_screen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    ListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp),label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),
      ],
        currentIndex: _currentIndex,
        backgroundColor: Colors.pink.shade100,
        selectedFontSize: 18,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SecondFont',
        ),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(
            fontFamily: 'SecondFont'
        ),
        selectedItemColor: Colors.pink,
        iconSize: 30,
        unselectedIconTheme: IconThemeData(
          size: 24,
        ),
        unselectedFontSize: 14,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}