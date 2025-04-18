import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class ImageAddress extends StatefulWidget {
  const ImageAddress(
      {super.key,
      required this.controller,
      this.small = false,
      required this.text});
  final AnimationController controller;
  final bool small;
  final String text;

  @override
  ImageAddressState createState() => ImageAddressState();
}

class ImageAddressState extends State<ImageAddress> {
  late Animation<double> _animation;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.8, 0.9, curve: Curves.easeInOut),
    );

    _animation = CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.7, 0.8, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: _animation,
        axisAlignment: -1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.rh(context),
              horizontal: widget.small ? 8.rw(context) : 14.rw(context)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: widget.small ? 30.rh(context) : 46.rh(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:
                      Colors.white.withOpacity(0.5), // semi-transparent white
                ),
                child: Row(
                  mainAxisAlignment: widget.small
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: widget.small ? 4.rw(context) : 60.rw(context),
                    ),
                    FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          textAlign: widget.small ? TextAlign.left : null,
                          widget.text,
                          style: TextStyle(
                              fontSize: widget.small
                                  ? 14.rf(context)
                                  : 15.rf(context)),
                        )),
                    if (widget.small) const Expanded(child: SizedBox()),
                    Container(
                      margin: const EdgeInsets.all(1.5),
                      height: widget.small ? 27.rh(context) : 44.rh(context),
                      width: widget.small ? 27.rw(context) : 44.rw(context),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: widget.small ? 6.rh(context) : 12.rh(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
