import 'package:flutter/material.dart';
import 'package:translation_test/navigation_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Euclid'),
      home: const Dashboard(),
    );
  }
}
