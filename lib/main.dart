import 'package:flutter/material.dart';
import 'package:translation_test/fade.dart';
import 'package:translation_test/home.dart';
import 'package:translation_test/playground.dart';
import 'package:translation_test/slide_in.dart';
import 'package:translation_test/widgets/slide_up_down.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Euclid'),
      home: HomeScreen(),
    );
  }
}
