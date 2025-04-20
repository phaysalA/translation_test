import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  const FadeIn(
      {super.key,
      required this.child,
      required this.controller,
      this.begin = 0.2,
      this.end = 0.3});
  final Widget child;
  final AnimationController controller;
  final double begin, end;

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
      curve: const Interval(0.2, 0.3, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}
