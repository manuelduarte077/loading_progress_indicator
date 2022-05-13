import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class BallBeatProgressIndicator extends SpinnerIndicator {
  //scale x ,y
  final scaleDoubles = [0.3, 0.3, 0.3];
  final delays = [350, 0, 350];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    const circleSpacing = 4;
    final width = size.width;
    final height = size.height;
    final radius = width / 6;
    final x = width / 2 - (radius * 2 + circleSpacing);
    final y = height / 2;

    for (int i = 0; i < 3; i++) {
      canvas.save();
      final translateX = x + (radius * 2) * i + circleSpacing * i;
      canvas.translate(translateX, y);
      canvas.scale(scaleDoubles[i], scaleDoubles[i]);
      canvas.drawCircle(const Offset(0, 0), radius, paint!);
      canvas.restore();
    }
  }

  @override
  List<AnimationController> animation() {
    List<AnimationController> controllers = [];

    for (var i = 0; i < 3; i++) {
      AnimationController sizeController = AnimationController(
          duration: const Duration(milliseconds: 375), vsync: context);
      final delayedAnimation =
          Tween(begin: 0.3, end: 1.0).animate(sizeController);
      delayedAnimation.addListener(() {
        scaleDoubles[i] = delayedAnimation.value;
        postInvalidate();
      });
      // size.
      controllers.add(sizeController);
    }
    return controllers;
  }

  @override
  void startAnim(AnimationController controller) {
    controller.repeat(reverse: true);
  }

  @override
  startAnims(List<AnimationController> controllers) {
    for (var i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) startAnim(controllers[i]);
      });
    }
  }
}
