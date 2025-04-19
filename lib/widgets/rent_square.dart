import 'package:flutter/material.dart';
import 'package:translation_test/utilities/utilities.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/animated_counter.dart';

class RentSquare extends StatelessWidget {
  const RentSquare({
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
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            'Rent',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13.rf(context),
              color: brown,
            ),
          ),
          SizedBox(
            height: 16.rh(context),
          ),
          AnimatedCounter(
              count: 2212, textColor: brown, controller: _controller),
          Text(
            'offers',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13.rf(context),
              color: brown,
            ),
          ),
        ],
      ),
    );
  }
}
