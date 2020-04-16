import 'dart:async';

import 'package:flutter/cupertino.dart';

class WorkoutTimer {

  Timer _timer;

  static final WorkoutTimer _instance = WorkoutTimer._internal();

  factory WorkoutTimer() => _instance;

  WorkoutTimer._internal();


  void startTimer(Duration interval, VoidCallback callback) {
    _timer = new Timer.periodic(interval, (Timer t) => callback());
  }

  void stopTimer() {
    _timer.cancel();
  }

}