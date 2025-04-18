import 'package:flutter/material.dart';
import 'package:translation_test/utilities.dart';

class FadeIn extends StatefulWidget {
  const FadeIn({super.key, required this.text, required this.controller});
  final String text;
  final AnimationController controller;

  @override
  FadeInState createState() => FadeInState();
}

class FadeInState extends State<FadeIn> {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.2, 0.3, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 24, color: brown),
      ),
    );
  }
}
