import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class CustomNavBarItem extends StatefulWidget {
  final VoidCallback onTap;
  final String icon;
  final bool isSelected;

  const CustomNavBarItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
  });

  @override
  State<CustomNavBarItem> createState() => _CustomNavBarItemState();
}

class _CustomNavBarItemState extends State<CustomNavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleRadius;
  late Animation<double> _rippleOpacity;

  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Ripple animation
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rippleRadius = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 25, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
          parent: _rippleController,
          curve: const Interval(0, 1, curve: Curves.easeOut)),
    );

    _rippleOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 0.4).chain(CurveTween(curve: Curves.easeIn)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: ConstantTween(0.4),
        weight: 80,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.4, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
    ]).animate(
      CurvedAnimation(
          parent: _rippleController,
          curve: const Interval(0, 1, curve: Curves.easeInOut)),
    );

    _colorAnimation = TweenSequence<Color?>([
      // Phase 1: Black (low opacity) → White
      TweenSequenceItem(
        tween: ColorTween(
          begin: Colors.black.withOpacity(0.3),
          end: Colors.white,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),

      // Phase 2: White → Orange
      TweenSequenceItem(
        tween: ColorTween(
          begin: Colors.white,
          end: Colors.orange,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
        parent: _rippleController,
        curve: const Interval(0.1, 1, curve: Curves.easeIn)));

    if (widget.isSelected) {
      _rippleController.forward(from: 0.8);
    }
  }

  void _handleTap() {
    // Reset everything before replaying
    _rippleController.forward(from: 0);

    widget.onTap();
  }

  @override
  void didUpdateWidget(covariant CustomNavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _rippleController.forward(from: 0);
    }
    if (!widget.isSelected && oldWidget.isSelected) {
      _rippleController.reset();
    }
  }

  @override
  void dispose() {
    _rippleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, _) {
              return CustomPaint(
                painter: RipplePainter(
                  radius: _rippleRadius.value,
                  opacity: _rippleOpacity.value,
                ),
                child: const SizedBox(width: 50, height: 50),
              );
            },
          ),
          AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, _) {
              return ClipRRect(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 6.rw(context),
                  ),
                  padding: EdgeInsets.all(
                      widget.isSelected ? 14.rw(context) : 12.rw(context)),
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    widget.icon,
                    height: 20.rh(context),
                    width: 20.rw(context),
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double radius;
  final double opacity;

  RipplePainter({required this.radius, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.opacity != opacity;
  }
}
