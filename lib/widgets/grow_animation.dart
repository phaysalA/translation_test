import 'package:flutter/material.dart';

class GrowAnimation extends StatefulWidget {
  const GrowAnimation(
      {super.key,
      required this.child,
      required this.controller,
      this.alignment,
      this.begin = 0.0,
      this.end = 0.35});
  final Widget child;
  final AnimationController controller;
  final double begin, end;
  final Alignment? alignment;
  @override
  GrowAnimationState createState() => GrowAnimationState();
}

class GrowAnimationState extends State<GrowAnimation> {
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Interval(widget.begin, widget.end, curve: Curves.easeInOut),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: widget.alignment ?? Alignment.center,
      scale: _scale,
      child: widget.child,
    );
  }
}
