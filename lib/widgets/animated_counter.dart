import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int count;
  final Color textColor;
  final AnimationController controller;

  const AnimatedCounter(
      {super.key,
      required this.count,
      required this.textColor,
      required this.controller});
  @override
  AnimatedCounterState createState() => AnimatedCounterState();
}

class AnimatedCounterState extends State<AnimatedCounter> {
  late Animation<int> _counter;

  @override
  void initState() {
    super.initState();

    _counter = IntTween(begin: 0, end: widget.count).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(0.35, 0.5, curve: Curves.linear),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _counter,
      builder: (context, child) => Text(
        '${_counter.value}',
        style: TextStyle(
            fontSize: 48, fontWeight: FontWeight.bold, color: widget.textColor),
      ),
    );
  }
}
