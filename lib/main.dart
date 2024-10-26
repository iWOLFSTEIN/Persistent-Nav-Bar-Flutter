import 'package:flutter/material.dart';
import 'package:test_project/home.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const Home(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[900]),
    );
  }
}
