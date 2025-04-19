import 'package:flutter/material.dart';
import 'package:translation_test/utilities/utilities.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class LeadingAddress extends StatefulWidget {
  const LeadingAddress({super.key, required this.controller});
  final AnimationController controller;

  @override
  LeadingAddressState createState() => LeadingAddressState();
}

class LeadingAddressState extends State<LeadingAddress> {
  late Animation<double> _animation;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.2, 0.45, curve: Curves.easeInOut),
    );

    _animation = CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: _animation,
          axisAlignment: -1.0,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              width: 160.rw(context),
              height: 42.rh(context),
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: brown,
                        size: 16.rh(context),
                      ),
                      Text(
                        'Saint Petersburg',
                        style: TextStyle(
                          fontSize: 13.rf(context),
                          color: brown,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
