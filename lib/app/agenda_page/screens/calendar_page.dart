import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/dates_list.dart';
import 'package:lifecoach_app/app/agenda_page/models/notes.dart';
import 'package:lifecoach_app/app/agenda_page/screens/edit_task.dart';
import 'package:lifecoach_app/app/agenda_page/utils/dbHelper.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/calendar_dates.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/task_container.dart';
import 'package:lifecoach_app/app/agenda_page/screens/create_new_task_page.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/back_button.dart';
import 'dart:math' as math;

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  List<bool> isSelected = List.generate(1, (_) => false);
  List<Notes> allNotes = new List<Notes>();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  AnimationController _animationController;
  String saa = 'bos';

  @override
  void initState() {
    getNotes();
    print('Async done');
    _animationController = AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 5000),
    );

    super.initState();
  }

  void _handleOnPressed() {
    // _animationController =
    //     AnimationController( vsync: this,
    //       duration: new Duration(milliseconds: 5000),
    //     );
    // _animationController.repeat();

    getNotes();
  }

  void getNotes() async {
    var notesFuture = _databaseHelper.getAllNotes();
    print('bura calisiyo');
    await notesFuture.then((data) {
      setState(() {
        this.allNotes = data;
        if (allNotes == null) allNotes = [];
      });
    });
  }

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
          child: Column(
            children: <Widget>[
              MyBackButton(
                pushPop: false,
              ),
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      saa,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Productive Day, Sourav',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'April, 2020',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: RotationTransition(
                        child: Icon(Icons.refresh),
                        turns: _animationController,
                      ),
                      onTap: () => _handleOnPressed(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: allNotes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: UniqueKey(),
                                child: TaskContainer(
                                  title: allNotes[index].title,
                                  subtitle: allNotes[index].description,
                                  startTime: allNotes[index].startTime,
                                  endTime: allNotes[index].endTime,
                                  boxColor: LightColors.kLightYellow2,
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    await _databaseHelper
                                        .delete(allNotes[index].id);
                                    print(index);
                                    getNotes();
                                    return true;
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => EditTask(
                                                  taskID: allNotes[index].id,
                                                )));
                                    return false;
                                  }
                                  return null;
                                },
                                background: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.0),
                                  color: Colors.redAccent,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                                secondaryBackground: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.0),
                                  color: Colors.orangeAccent,
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    for (int i = 0; i < allNotes.length; i++) {
                      print(allNotes[i].toMap());
                    }
                  },
                  child: Text(allNotes.length.toString()))
            ],
          ),
        ),
      ),
    );
  }
}
