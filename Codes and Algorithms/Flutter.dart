import 'package:flutter/services.dart';
import 'dart:io';

// Braille mapping for letters a-z and numbers 0-9
// Each character maps to a 6-dot Braille cell (string of 1s and 0s)
const Map<String, String> brailleMap = {
  'a': '100000', 'b': '101000', 'c': '110000', 'd': '110100', 'e': '100100',
  'f': '111000', 'g': '111100', 'h': '101100', 'i': '011000', 'j': '011100',
  'k': '100010', 'l': '101010', 'm': '110010', 'n': '110110', 'o': '100110',
  'p': '111010', 'q': '111110', 'r': '101110', 's': '011010', 't': '011110',
  'u': '100011', 'v': '101011', 'w': '011101', 'x': '110011', 'y': '110111',
  'z': '100111',
  '0': '011100', '1': '100000', '2': '101000', '3': '110000',
  '4': '110100', '5': '100100', '6': '111000', '7': '111100',
  '8': '101100', '9': '011000'
};

// Vibration durations in milliseconds
const int shortVibrate = 100;      // Active dot
const int errorVibrate = 50;       // Inactive dot (error)
const int nextLetterVibrate = 300; // Change letter

// Function to vibrate for a single duration
Future<void> vibrate(int duration) async {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
    await Future.delayed(Duration(milliseconds: duration));
  } else if (Platform.isIOS) {
    HapticFeedback.lightImpact();
    await Future.delayed(Duration(milliseconds: duration));
  }
}

// Function to convert text to Braille vibrations
Future<void> vibrateBraille(String text) async {
  for (var char in text.toLowerCase().split('')) {
    final code = brailleMap[char] ?? '000000'; // Default empty cell

    for (var dot in code.split('')) {
      if (dot == '1') {
        await vibrate(shortVibrate); // Active dot
      } else {
        await vibrate(errorVibrate); // Inactive dot / error
      }
      await Future.delayed(Duration(milliseconds: 50)); // Pause between dots
    }

    // Vibration for next letter
    await vibrate(nextLetterVibrate);
    await Future.delayed(Duration(milliseconds: 50)); // Pause after letter
  }
}

// Example usage:
// await vibrateBraille("hello 123");
