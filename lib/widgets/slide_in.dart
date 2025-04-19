import 'package:flutter/material.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class SlideIn extends StatefulWidget {
  const SlideIn({super.key, required this.controller, required this.text});
  final AnimationController controller;
  final String text;

  @override
  SlideInState createState() => SlideInState();
}

class SlideInState extends State<SlideIn> {
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // start well below
      end: const Offset(0, 0), // slide up into view
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.3, 0.4, curve: Curves.easeIn),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50, // This is the clipping box

      child: ClipRect(
        child: SlideTransition(
          position: _slideAnimation,
          child: Text(
            widget.text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 34.rf(context),
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
