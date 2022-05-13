import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class LineScalePulseOutProgressIndicator extends SpinnerIndicator {
  final scaleYDoubles = [1.0, 1.0, 1.0, 1.0, 1.0];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    final translateX = size.width / 11;
    final translateY = size.height / 2;
    for (int i = 0; i < 5; i++) {
      canvas.save();
      canvas.translate((2 + i * 2) * translateX - translateX / 2, translateY);
      canvas.scale(1.0, scaleYDoubles[i]);
      final rectF = RRect.fromLTRBR(-translateX / 2, -size.height / 2.5,
          translateX / 2, size.height / 2.5, const Radius.circular(5));
      canvas.drawRRect(rectF, paint!);
      canvas.restore();
    }
  }

  @override
  List<AnimationController> animation() {
    List<AnimationController> controllers = [];
    for (int i = 0; i < 5; i++) {
      final sizeController = AnimationController(
          duration: const Duration(milliseconds: 500), vsync: context);
      final alphaTween = Tween(begin: 1.0, end: 0.3).animate(sizeController);
      sizeController.addListener(() {
        scaleYDoubles[i] = alphaTween.value;
        postInvalidate();
      });
      controllers.add(sizeController);
    }
    return controllers;
  }

  @override
  startAnims(List<AnimationController> controllers) {
    var delays = [500, 250, 0, 250, 500];
    for (var i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) controllers[i].repeat(reverse: true);
      });
    }
  }
}
