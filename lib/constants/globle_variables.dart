import 'package:flutter/material.dart';

class GlobalVariables {
  static const appBarGradient = LinearGradient(colors: [
    Color.fromARGB(255, 29, 201, 192),
    Color.fromARGB(150, 122, 194, 153),
  ], stops: [
    0.5,
    1.0
  ]);

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const selectedNavBarColor = Colors.cyan;
  static const unselectNavBarColor = Colors.black87;
  static const Color grayBackgroundColor = Color(0xffebecee);
}
