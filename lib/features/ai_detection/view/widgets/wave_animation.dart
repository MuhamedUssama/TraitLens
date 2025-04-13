import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    animation = Tween(begin: 0.0, end: 1000000.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240.w,
        height: 240.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/Ellipse-30.png'),
            Image.asset('assets/images/Ellipse-14.png'),
            AnimatedBuilder(
              animation: animation,
              child: Image.asset('assets/images/green-left.png'),
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value * 0.2 * 0.0001,
                  child: child,
                );
              },
            ),
            AnimatedBuilder(
              animation: animation,
              child: Image.asset('assets/images/pink-left.png'),
              builder: (context, child) {
                return Transform.rotate(
                  angle: -animation.value * 0.3 * 0.0001,
                  child: child,
                );
              },
            ),
            AnimatedBuilder(
              animation: animation,
              child: Image.asset('assets/images/Ellipse-29.png'),
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value * 0.6 * 0.0001,
                  child: child,
                );
              },
            ),
            AnimatedBuilder(
              animation: animation,
              child: Image.asset('assets/images/blue-right.png'),
              builder: (context, child) {
                return Transform.rotate(
                  angle: -animation.value * 0.5 * 0.0001,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
