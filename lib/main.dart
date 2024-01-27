import 'package:flutter/material.dart';
import 'package:portfolio/Components/NavBar.dart';
import 'package:portfolio/Pages/HomePage.dart';
import 'package:portfolio/Utils/ResponsiveLayout.dart';
import 'package:portfolio/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gaurav's Portfolio",
      onGenerateRoute: (settings) => generateRoute(settings),
      home: MyHomePage(),
    );
  }
}

