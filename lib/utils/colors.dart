import 'dart:ui';

import 'package:flutter/material.dart';

class Palette {

  static const int _themePrimaryValue = 0xFF192C6A;
  
  static const MaterialColor theme = MaterialColor(
    _themePrimaryValue,
    <int, Color>{
      50: Color(0xFF192C6A),
      100: Color(0xFF192C6A),
      200: Color(0xFF192C6A),
      300: Color(0xFF192C6A),
      400: Color(0xFF192C6A),
      500: Color(_themePrimaryValue),
      600: Color(0xFF192C6A),
      700: Color(0xFF192C6A),
      800: Color(0xFF192C6A),
      900: Color(0xFF192C6A),
    },
  );
  
  static const Color theme1 = Color(0xFF192C6A);
  static const Color fillcolor = Color.fromARGB(255, 234, 235, 236);
  static const Color fontcolor = Color.fromARGB(255, 167, 50, 24);

}