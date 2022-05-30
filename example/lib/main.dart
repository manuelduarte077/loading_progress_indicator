import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_grid_pulse_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_pulse_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_scale_multiple_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_scale_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_spin_fade_loader_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/line_scale_party_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/line_scale_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/line_scale_pulse_out_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/pacman_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loading Progress Indicator'),
          elevation: 0,
        ),
        body: LoadingProgressList(),
      ),
    );
  }
}

class LoadingProgressList extends StatelessWidget {
  final indicatorProgressList = [
    BallPulseProgressIndicator(),
    PacmanProgressIndicator(),
    BallBeatProgressIndicator(),
    BallGridPulseProgressIndicator(),
    BallScaleProgressIndicator(),
    BallScaleMultipleProgressIndicator(),
    BallSpinFadeLoaderProgressIndicator(),
    LineScaleProgressIndicator(),
    LineScalePartyProgressIndicator(),
    LineScalePulseOutProgressIndicator(),
  ];

  LoadingProgressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: indicatorProgressList.length,
          itemBuilder: (context, index) {
            return Center(
              child: LoadingProgressIndicator(
                indicator: indicatorProgressList[index],
                size: 50,
                color: Colors.indigo,
              ),
            );
          }),
    );
  }
}
