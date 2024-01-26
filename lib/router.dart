import 'package:flutter/material.dart';
import 'package:portfolio/ContactScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ContactScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ContactScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text("4040")),
        ),
      );
  }
}
