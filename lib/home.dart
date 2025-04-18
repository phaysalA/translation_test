import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translation_test/fade.dart';
import 'package:translation_test/slide_in.dart';
import 'package:translation_test/utilities.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/widgets/animated_counter.dart';
import 'package:translation_test/widgets/bottom_slider.dart';
import 'package:translation_test/widgets/buy_circle.dart';
import 'package:translation_test/widgets/grow_animation.dart';
import 'package:translation_test/widgets/leading_address.dart';
import 'package:translation_test/widgets/profile_picture.dart';
import 'package:translation_test/widgets/rent_square.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.1, 0.9],
            colors: [
              orange.withOpacity(0.01),
              orange.withOpacity(0.3),
            ],
            begin: const Alignment(-0.85, -1),
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.rh(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LeadingAddress(
                        controller: _controller,
                      ),
                      GrowAnimation(
                        controller: _controller,
                        child: const ProfilePicture(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.rh(context),
                  ),
                  FadeIn(
                    text: 'Hi, Marina',
                    controller: _controller,
                  ),
                  SlideIn(
                    text: 'let\'s select your',
                    controller: _controller,
                  ),
                  SlideIn(
                    text: 'perfect place',
                    controller: _controller,
                  ),
                  SizedBox(
                    height: 30.rh(context),
                  ),
                  Row(
                    children: [
                      GrowAnimation(
                        begin: 0.3,
                        end: 0.5,
                        controller: _controller,
                        child: BuyCircle(controller: _controller),
                      ),
                      SizedBox(
                        width: 8.rw(context),
                      ),
                      GrowAnimation(
                        begin: 0.3,
                        end: 0.5,
                        controller: _controller,
                        child: RentSquare(controller: _controller),
                      ),
                    ],
                  )
                ],
              ),
            ),
            BottomSlider(controller: _controller)
          ],
        ),
      ),
    );
  }
}
