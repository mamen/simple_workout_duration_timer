import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wrokout Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkoutTimerPage(),
        debugShowCheckedModeBanner: false,
    );
  }
}

class WorkoutTimerPage extends StatefulWidget {
  WorkoutTimerPage({Key key}) : super(key: key);

  @override
  _WorkoutTimerPageState createState() => _WorkoutTimerPageState();
}

class _WorkoutTimerPageState extends State<WorkoutTimerPage> {
  int _counter = 0;
  final int _timerMaxValue = 60;

  _WorkoutTimerPageState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTimeout();
  }

  void startTimeout() {
    var duration = Duration(seconds: 1);
    new Timer.periodic(duration, (Timer t) => handleTimeout());
  }

  void handleTimeout() {
    setState(() {
      (_counter > _timerMaxValue) ? _counter = 0 : _counter++;
    });
  }

  static Future<void> setEnabledSystemUIOverlays(
      List<SystemUiOverlay> overlays) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemChrome.setEnabledSystemUIOverlays');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(43, 69, 112, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: TextStyle(
                  color: Color.fromRGBO(168, 208, 219, 1), fontSize: 72),
            ),
          ],
        ),
      ),
    );
  }
}
