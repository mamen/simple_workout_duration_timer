import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_timer/settings.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

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
  Timer _timer;
  final AudioCache _audioCache = new AudioCache();

  _WorkoutTimerPageState(){
    setup();
  }

  void setup() async {
    hideStatusBar();
    await loadSoundCache();
    _timer = await createAndStartTimer();
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<void> loadSoundCache() async {
    _audioCache.clearCache();
    await _audioCache.fetchToMemory("sounds/tick.mp3");
  }

  Future<Timer> createAndStartTimer() async  {
    var duration = Duration(seconds: 1);
    return new Timer.periodic(duration, (Timer t) => handleTimeout());
  }

  Future<void> playTickSound() async {
    await _audioCache.play("sounds/tick.mp3");
  }

  Future<void> handleTimeout() async {
    await playTickSound();
    setState(() {
      (_counter > _timerMaxValue) ? _counter = 0 : _counter++;
    });
  }

  static Future<void> setEnabledSystemUIOverlays() async {
    await SystemChannels.platform.invokeMethod<void>('SystemChrome.setEnabledSystemUIOverlays');
  }

  void openSettings() {
    _timer.cancel();

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (ctxt) => new Settings()),
    );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: openSettings,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.settings, size: 52, color: Color.fromRGBO(168, 208, 219, 1),),
        elevation: 0,
      ),
    );
  }
}
