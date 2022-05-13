import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class BallSpinFadeLoaderProgressIndicator extends SpinnerIndicator {
  final scaleDoubles = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  final alphas = [255, 255, 255, 255, 255, 255, 255, 255];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    final radius = size.width / 10;
    for (int i = 0; i < 8; i++) {
      canvas.save();
      Offset point = circleAt(
          size.width, size.height, size.width / 2 - radius, i * (pi / 4));
      canvas.translate(point.dx, point.dy);
      canvas.scale(scaleDoubles[i], scaleDoubles[i]);
      paint!.color = paint.color.withAlpha(alphas[i]);
      canvas.drawCircle(const Offset(0, 0), radius, paint);
      canvas.restore();
    }
  }

  @override
  List<AnimationController> animation() {
    List<AnimationController> controllers = [];
    for (int i = 0; i < 8; i++) {
      final controller = AnimationController(
          duration: const Duration(milliseconds: 500), vsync: context);
      final alphaTween = IntTween(begin: 255, end: 77).animate(controller);
      final scaleTween = Tween(begin: 1.0, end: 0.4).animate(controller);

      controller.addListener(() {
        scaleDoubles[i] = scaleTween.value;
        alphas[i] = alphaTween.value;
        postInvalidate();
      });
      controllers.add(controller);
    }
    return controllers;
  }

  @override
  startAnims(List<AnimationController> controllers) {
    final delays = [0, 120, 240, 360, 480, 600, 720, 780, 840];
    for (var i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) controllers[i].repeat(reverse: true);
      });
    }
  }

  Offset circleAt(double width, double height, double radius, double angle) {
    final x = (width / 2 + radius * (cos(angle)));
    final y = (height / 2 + radius * (sin(angle)));
    return Offset(x, y);
  }
}
