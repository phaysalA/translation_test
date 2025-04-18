import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class SlideToRestWidget extends StatefulWidget {
  @override
  _SlideToRestWidgetState createState() => _SlideToRestWidgetState();
}

class _SlideToRestWidgetState extends State<SlideToRestWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // 1. From bottom (offscreen)
    // 2. Fully visible (at Offset(0, 0))
    // 3. Slide down slightly to rest at 40% screen height (Offset(0, 0.25))
    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, 1), // Start offscreen (bottom)
          end: Offset(0, 0), // Move to center (visible)
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(0, 0.25), // Move slightly down (rest at 40%)
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  void _start() {
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Slide in and Settle')),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(color: Colors.grey.shade200),
          ),

          // Animated widget
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.rw(context), vertical: 12.rh(context)),
                height: screenHeight * 0.65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                          height: 180.rh(context),
                          width: 500.rw(context),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/image_1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.rh(context),
                                  horizontal: 14.rw(context)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    height: 46.rh(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withOpacity(
                                          0.5), // semi-transparent white
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60.rw(context),
                                        ),
                                        Text(
                                          'Gladkova St., 25',
                                          style: TextStyle(
                                              fontSize: 15.rf(context)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(1.5),
                                          height: 44.rh(context),
                                          width: 44.rw(context),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 12.rh(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _start,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
