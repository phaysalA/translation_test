import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class SlideHeightControlledWidget extends StatefulWidget {
  @override
  _SlideHeightControlledWidgetState createState() =>
      _SlideHeightControlledWidgetState();
}

class _SlideHeightControlledWidgetState
    extends State<SlideHeightControlledWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // From 100% (off-screen) → 35% (showing full 65%) → 60% (shows 40%)
    _slideY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Slide to 65% then settle at 40%")),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _slideY,
            builder: (context, child) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: screenHeight * _slideY.value,
                child: Container(
                  height: 400.rh(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.rw(context), vertical: 12.rh(context)),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
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
                              child: Container(
                                height: 50.rh(context),
                                width: 100.rw(context),
                                decoration: BoxDecoration(color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
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
