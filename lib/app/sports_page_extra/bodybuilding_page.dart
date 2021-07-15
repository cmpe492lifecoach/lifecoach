import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/sports_page_extra/ExerciseMode.dart';

class BodyBuildingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Building"),
      ),
      body: ExerciseMode(),

    );
  }
}
