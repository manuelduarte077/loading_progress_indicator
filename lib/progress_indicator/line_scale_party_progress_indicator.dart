import 'package:flutter/widgets.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';

class LineScalePartyProgressIndicator extends SpinnerIndicator {
  final scaleDoubles = [1.0, 1.0, 1.0, 1.0];
  final durations = [630, 215, 505, 365];

  @override
  paint(Canvas canvas, Paint? paint, Size size) {
    final translateX = size.width / 9;
    final translateY = size.height / 2;

    for (int i = 0; i < 4; i++) {
      canvas.save();
      canvas.translate((2 + i * 2) * translateX - translateX / 2, translateY);
      canvas.scale(scaleDoubles[i], scaleDoubles[i]);
      final rectF = RRect.fromLTRBR(-translateX / 2, -size.height / 2.5,
          translateX / 2, size.height / 2.5, const Radius.circular(5));
      canvas.drawRRect(rectF, paint!);
      canvas.restore();
    }
  }

  @override
  List<AnimationController> animation() {
    List<AnimationController> controllers = [];
    for (int i = 0; i < 4; i++) {
      final sizeController = AnimationController(
          duration: Duration(milliseconds: durations[i]), vsync: context);
      final alphaTween = Tween(begin: 1.0, end: 0.4).animate(sizeController);
      sizeController.addListener(() {
        scaleDoubles[i] = alphaTween.value;
        postInvalidate();
      });
      controllers.add(sizeController);
    }
    return controllers;
  }

  @override
  startAnims(List<AnimationController> controllers) {
    final delays = [770, 290, 280, 740];
    for (var i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        if (context.mounted) controllers[i].repeat(reverse: true);
      });
    }
  }
}
