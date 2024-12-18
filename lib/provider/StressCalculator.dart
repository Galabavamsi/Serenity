import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StressCalculator with ChangeNotifier {
  int _depressionValue = 0; // Private variable to hold the total depression score
  int _anxietyValue = 0; // Private variable to hold the total anxiety score
  int _stressValue = 0; // Private variable to hold the total stress score

  // Method to add a rating value based on category
  void addRating(int value, String category) {
    if (category == 'd') {
      _depressionValue += value;
    } else if (category == 'a') {
      _anxietyValue += value;
    } else if (category == 's') {
      _stressValue += value;
    }
    notifyListeners(); // Notify listeners (optional here)
  }

  // Getters for the total values
  int get depressionValue => _depressionValue;
  int get anxietyValue => _anxietyValue;
  int get stressValue => _stressValue;

  // Method to reset all values
  void resetValues() {
    _depressionValue = 0;
    _anxietyValue = 0;
    _stressValue = 0;
    notifyListeners();
  }
}