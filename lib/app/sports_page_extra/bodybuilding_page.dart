import 'package:flutter/material.dart';

import 'ExerciseMode.dart';


class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
      ),
      body: ExerciseMode(),

    );
  }
}
