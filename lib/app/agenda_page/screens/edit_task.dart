import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/back_button.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';

class EditTask extends StatefulWidget {
  final int taskID;

  EditTask({this.taskID});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(children: <Widget>[
            MyBackButton(
              pushPop: false,
            ),
          ]),
        ),
      ),
    );
  }
}
