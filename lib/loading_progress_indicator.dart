import 'package:flutter/material.dart';
import 'package:loading_progress_indicator/progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_scale_progress_indicator.dart';

class LoadingProgressIndicator extends StatefulWidget {
  SpinnerIndicator? indicator;
  final double size;
  final Color color;

  LoadingProgressIndicator({
    Key? key,
    this.indicator,
    this.size = 50.0,
    this.color = Colors.white,
  }) : super(key: key) {
    if (indicator == null) {
      indicator = BallScaleProgressIndicator();
    } else {
      indicator = indicator;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return LoadingProgressState(indicator, size);
  }
}

class LoadingProgressState extends State<LoadingProgressIndicator>
    with TickerProviderStateMixin {
  SpinnerIndicator? indicator;
  double size;

  LoadingProgressState(this.indicator, this.size);

  @override
  void initState() {
    super.initState();
    indicator!.context = this;
    indicator!.start();
  }

  @override
  void dispose() {
    indicator!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(indicator, widget.color),
      size: Size.square(size),
    );
  }
}

class _Painter extends CustomPainter {
  SpinnerIndicator? indicator;
  Color color;
  Paint? defaultPaint;

  _Painter(this.indicator, this.color) {
    defaultPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.fill
      ..color = color
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    indicator!.paint(canvas, defaultPaint, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
