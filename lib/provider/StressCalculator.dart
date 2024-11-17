import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StressCalculator with ChangeNotifier {
  int _totalValue = 0; // Private variable to hold the total stress

  // Method to add a rating value
  void addRating(int value) {
    _totalValue += value;
    notifyListeners(); // Notify listeners (optional here)
  }
  // Getter for the total value
  int get totalValue => _totalValue;

  // Method to reset the totalValue
  void resetValue(){
    _totalValue = 0;
    notifyListeners();
  }
}

