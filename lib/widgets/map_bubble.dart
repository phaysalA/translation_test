import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/utilities/utilities.dart';
import 'package:translation_test/widgets/fade.dart';
import 'package:translation_test/widgets/grow_animation.dart';

class MapBubble extends StatefulWidget {
  const MapBubble(
      {super.key,
      required this.text,
      required this.startUpAnimController,
      required this.toggleAnimController});
  final String text;
  final AnimationController startUpAnimController;
  final AnimationController toggleAnimController;

  @override
  State<MapBubble> createState() => _MapBubbleState();
}

class _MapBubbleState extends State<MapBubble> {
  late Animation<double> _widthAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widthAnimation = Tween<double>(begin: 100, end: 60).animate(
      CurvedAnimation(
        parent: widget.toggleAnimController,
        curve: Curves.easeInOut,
      ),
    );

    widget.toggleAnimController.addListener(() {
      if (widget.toggleAnimController.status == AnimationStatus.forward) {
        setState(() {
          _showFirst = false;
        });
      } else if (widget.toggleAnimController.status ==
          AnimationStatus.reverse) {
        setState(() {
          _showFirst = true;
        });
      }
    });
  }

  bool _showFirst = true;
  @override
  Widget build(BuildContext context) {
    return GrowAnimation(
      begin: 0.4,
      end: 0.8,
      controller: widget.startUpAnimController,
      child: AnimatedBuilder(
        animation: widget.toggleAnimController,
        builder: (context, child) {
          return Container(
            width: _widthAnimation.value,
            padding: EdgeInsets.symmetric(
                vertical: 14.rh(context),
                horizontal: _showFirst ? 8.rw(context) : 10.rw(context)),
            decoration: const BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            child: FadeIn(
              controller: widget.startUpAnimController,
              begin: 0.4,
              end: 0.8,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _showFirst
                    ? Text(
                        widget.text,
                        key: const ValueKey(1),
                        style: TextStyle(
                            fontSize: 12.rf(context), color: Colors.white),
                      )
                    : SvgPicture.asset(
                        'assets/icons/building.svg',
                        height: 20.rh(context),
                        width: 20.rw(context),
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
