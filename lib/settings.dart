import 'package:flutter/material.dart';
import 'package:workout_timer/workout_timer.dart';

class Settings extends StatelessWidget {


  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(43, 69, 112, 1),
      body: new Text("Another Page...!!!!!!"),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.transparent,
        child: Icon(Icons.close, size: 52, color: Color.fromRGBO(168, 208, 219, 1),),
        elevation: 0,
      ),
    );
  }
}