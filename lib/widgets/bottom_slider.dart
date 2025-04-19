import 'package:flutter/material.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/image_address.dart';

class BottomSlider extends StatefulWidget {
  const BottomSlider({super.key, required this.controller});
  final AnimationController controller;

  @override
  BottomSliderState createState() => BottomSliderState();
}

class BottomSliderState extends State<BottomSlider> {
  late Animation<Offset> _slideAnimation;
  bool _animationDone = false;

  @override
  void initState() {
    super.initState();

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0, 1), // Start offscreen (bottom)
          end: const Offset(0, 0.5), // Move to center (visible)
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 34,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0, 0.5), // Start offscreen (bottom)
          end: const Offset(0, 0.05), // Move to center (visible)
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 34,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0, 0.05),
          end: const Offset(0, 0.15), // Move slightly down (rest at 40%) 0.225
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 33,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0, 0.15),
          end: const Offset(0, 0.3), // Move slightly down (rest at 40%) 0.225
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 33,
      ),
    ]).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.5, 0.9, curve: Curves.linear),
    ));

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationDone = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _animationDone
        ? _buildDraggableSheet(context)
        : _buildInitialAnimation();
  }

  Widget _buildInitialAnimation() {
    return SlideTransition(
      position: _slideAnimation,
      child: _buildSheetContainer(context),
    );
  }

  Widget _buildDraggableSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return _buildSheetContainer(context,
            scrollController: scrollController);
      },
    );
  }

  Widget _buildSheetContainer(BuildContext context,
      {ScrollController? scrollController}) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 6.rw(context), vertical: 8.rh(context)),
        height: screenHeight * 0.7,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                    height: 180.rh(context),
                    width: 500.rw(context),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/image_1.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ImageAddress(
                            controller: widget.controller,
                            text: 'Gladkova St., 25',
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 8.rh(context),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                        height: 300.rh(context),
                        width: 180.rw(context),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/image_2.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ImageAddress(
                                small: true,
                                controller: widget.controller,
                                text: 'Gubina St., 11',
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 8.rw(context),
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                            height: 145.rh(context),
                            width: 175.rw(context),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/image_3.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ImageAddress(
                                    controller: widget.controller,
                                    text: 'Trefoleva St., 43',
                                    small: true,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 12.rh(context),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                            height: 145.rh(context),
                            width: 175.rw(context),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/image_4.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ImageAddress(
                                    controller: widget.controller,
                                    text: 'Sedova St., 22',
                                    small: true,
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
