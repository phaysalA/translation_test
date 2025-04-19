import 'package:flutter/material.dart';
import 'package:translation_test/utilities/utilities.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/animated_counter.dart';

class BuyCircle extends StatelessWidget {
  const BuyCircle({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 22.rh(context),
          right: 12.rw(context),
          left: 12.rw(context),
          top: 16.rh(context)),
      width: 170.rw(context),
      height: 170.rh(context),
      decoration: const BoxDecoration(color: orange, shape: BoxShape.circle),
      child: Column(
        children: [
          Text(
            'BUY',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13.rf(context),
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 16.rh(context),
          ),
          AnimatedCounter(
              count: 1034, textColor: Colors.white, controller: _controller),
          Text(
            'offers',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13.rf(context),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
