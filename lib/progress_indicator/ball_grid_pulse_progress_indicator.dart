import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class BallGridPulseProgressIndicator extends SpinnerIndicator {
  final scaleDoubles = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  final alphaInts = [255, 255, 255, 255, 255, 255, 255, 255, 255];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    const circleSpacing = 4;
    final width = size.width;
    final radius = (width - circleSpacing * 4) / 6;
    final x = width / 2 - (radius * 2 + circleSpacing);
    final y = width / 2 - (radius * 2 + circleSpacing);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        canvas.save();
        final translateX = x + (radius * 2) * j + circleSpacing * j;
        final translateY = y + (radius * 2) * i + circleSpacing * i;
        canvas.translate(translateX, translateY);
        paint!.color = paint.color.withAlpha(alphaInts[3 * i + j]);
        canvas.drawCircle(
            const Offset(0, 0), radius * scaleDoubles[3 * i + j], paint);
        canvas.restore();
      }
    }
  }

  @override
  List<AnimationController> animation() {
    final durations = [720, 1020, 1280, 1420, 1450, 1180, 870, 1450, 1060];

    List<AnimationController> controllers = [];
    for (int i = 0; i < 9; i++) {
      final sizeController = AnimationController(
          duration: Duration(milliseconds: durations[i]), vsync: context);
      final alphaTween = IntTween(begin: 122, end: 255).animate(sizeController);
      sizeController.addListener(() {
        scaleDoubles[i] = sizeController.value;
        alphaInts[i] = alphaTween.value;
        postInvalidate();
      });
      controllers.add(sizeController);
    }
    return controllers;
  }

  @override
  startAnims(List<AnimationController> controllers) {
    final delays = [-60, 250, -170, 480, 310, 30, 460, 780, 450];
    for (var i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) controllers[i].repeat(reverse: true);
      });
    }
  }
}
