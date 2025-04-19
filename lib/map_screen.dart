import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/custom_ripple_button.dart';
import 'package:translation_test/widgets/grow_animation.dart';
import 'package:translation_test/widgets/map_bubble.dart';
import 'package:translation_test/widgets/options_tile.dart';
import 'package:translation_test/widgets/pill_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.controller});
  final AnimationController controller;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _toggleAnimationController;
  late AnimationController _optionsAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _toggleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _optionsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _controller = widget.controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _toggleAnimationController.dispose();
    _optionsAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(
                  'assets/images/map_image.jpg',
                ),
                fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 65.rh(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GrowAnimation(
                      end: 0.5,
                      controller: _controller,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.rh(context),
                              horizontal: 8.rw(context)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5.rw(context),
                              ),
                              SvgPicture.asset(
                                'assets/icons/search.svg',
                                height: 22.rh(context),
                                width: 22.rw(context),
                                colorFilter: const ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                              ),
                              SizedBox(
                                width: 10.rw(context),
                              ),
                              Text(
                                'Saint Petersburg',
                                style: TextStyle(fontSize: 14.rf(context)),
                              ),
                              SizedBox(
                                width: 100.rw(context),
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 7.rw(context),
                    ),
                    GrowAnimation(
                      end: 0.5,
                      controller: _controller,
                      child: Container(
                        padding: EdgeInsets.all(8.rw(context)),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/icons/filter.svg',
                          height: 22.rh(context),
                          width: 22.rw(context),
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: const Alignment(-0.5, -0.5),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '10,3 mn ₽',
              ),
            ),
            Align(
              alignment: const Alignment(-0.36, -0.35),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '11 mn ₽',
              ),
            ),
            Align(
              alignment: const Alignment(0.72, -0.3),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '7,8 mn ₽',
              ),
            ),
            Align(
              alignment: const Alignment(-0.7, 0.07),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '13,3 mn ₽',
              ),
            ),
            Align(
              alignment: const Alignment(0.72, 0),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '8,5 mn ₽',
              ),
            ),
            Align(
              alignment: const Alignment(0.47, 0.27),
              child: MapBubble(
                startUpAnimController: _controller,
                toggleAnimController: _toggleAnimationController,
                text: '6,95 mn ₽',
              ),
            ),
            GrowAnimation(
              alignment: const Alignment(-0.82, 0.58),
              end: 0.5,
              controller: _controller,
              child: Align(
                  alignment: const Alignment(-0.9, 0.62),
                  child: CustomRippleButton(
                      onTap: () {
                        _optionsAnimationController.forward();
                      },
                      icon: 'assets/icons/layers.svg')),
            ),
            GrowAnimation(
              alignment: const Alignment(-0.82, 0.71),
              end: 0.5,
              controller: _controller,
              child: Align(
                  alignment: const Alignment(-0.9, 0.75),
                  child: CustomRippleButton(
                      isEnabled: false,
                      onTap: () {},
                      icon: 'assets/icons/location.svg')),
            ),
            GrowAnimation(
              alignment: const Alignment(0.67, 0.71),
              end: 0.5,
              controller: _controller,
              child: const Align(
                  alignment: Alignment(0.92, 0.75), child: PillButton()),
            ),
            GrowAnimation(
              alignment: const Alignment(-0.82, 0.58),
              end: 1,
              controller: _optionsAnimationController,
              child: Align(
                  alignment: const Alignment(-0.9, 0.55),
                  child: OptionsTile(
                    dismiss: () {
                      _toggleAnimationController.forward();
                      _optionsAnimationController.reverse();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
