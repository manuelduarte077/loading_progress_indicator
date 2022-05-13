import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class BallScaleMultipleProgressIndicator extends SpinnerIndicator {
  final scaleDoubles = [0.0, 0.0, 0.0];
  final alphaInts = [255, 255, 255];
  final delays = [0, 200, 200];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    const circleSpacing = 4;
    final width = size.width;
    final height = size.height;
    for (int i = 0; i < 3; i++) {
      paint!.color = paint.color.withAlpha(alphaInts[i]);
      canvas.drawCircle(Offset(width / 2, height / 2),
          (width / 2 - circleSpacing) * scaleDoubles[i], paint);
    }
  }

  @override
  List<AnimationController> animation() {
    List<AnimationController> controllers = [];
    for (int i = 0; i < 3; i++) {
      final sizeController = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: context);
      final alphaTween = IntTween(begin: 255, end: 0).animate(sizeController);
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
  startAnims(List<AnimationController> controllers) async {
    for (var i = 0; i < controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) controllers[i].repeat();
      });
    }
  }
}
