import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lifecoach_app/app/agenda_page/models/notes.dart';
import 'package:lifecoach_app/app/agenda_page/screens/edit_task.dart';
import 'package:lifecoach_app/app/agenda_page/utils/dbHelper.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/task_container.dart';
import 'package:lifecoach_app/app/agenda_page/screens/create_new_task_page.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/back_button.dart';


class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  List<bool> isSelected = List.generate(1, (_) => false);
  List<Notes> allNotes;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  AnimationController controller;
  Animation<double> animation;
  String saa = 'Tasks';
  Color oldColor;

  @override
  void initState() {
    getNotes();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ).drive(Tween(begin: 0, end: 3));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getNotes() async {
    var notesFuture = _databaseHelper.getAllNotes();

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
                pushPop: 2,
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
                      child: MaterialButton(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DateFormat('d MMMM').format(DateTime.now())} ${DateFormat('EEEE').format(DateTime.now())} ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller
                        ..reset()
                        ..forward();
                      getNotes();
                    },
                    child: RotationTransition(
                      turns: animation,
                      child: Icon(Icons.refresh_outlined),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: SingleChildScrollView(


                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        allNotes.length==0
                        ?Container(

                          width: MediaQuery.of(context).size.width*0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: LightColors.kDarkYellow,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                              "Add Your First Task Now",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),),
                        )
                        :Expanded(
                          flex: 1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: allNotes.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool taskDone=isCompleted(index);
                              return Dismissible(
                                key: UniqueKey(),
                                  child: TaskContainer(
                                    title: allNotes[index].title,
                                    subtitle: allNotes[index].description,
                                    startTime: allNotes[index].startTime,
                                    endTime: allNotes[index].endTime,
                                    category: allNotes[index].category,
                                    color: Color(int.parse(
                                        "0x7a${allNotes[index].color.toString().substring(10, 16)}")),
                                    icon: taskDone
                                        ? Icons.check
                                        : Icons.access_time,
                                  ),

                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    await _databaseHelper
                                        .delete(allNotes[index].id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Task Deleted')));
                                    getNotes();
                                    return true;
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => EditTaskPage(
                                                  taskID: allNotes[index].id,
                                                  listID: index,
                                                )));
                                    return false;
                                  }
                                  return null;
                                },
                                background: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                                secondaryBackground: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.0),
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
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

  bool isCompleted(int i ){
    bool taskDone = false;
    bool keepSearching=false;
    if (int.parse(
        allNotes[i].date.substring(6, 10)) <
        DateTime.now().year) {
      taskDone = true;
    }
    if(int.parse(
        allNotes[i].date.substring(6, 10)) ==
        DateTime.now().year)
    {keepSearching=true;
    }
    if (keepSearching &&
        int.parse(allNotes[i]
            .date
            .substring(3, 5)) <
            DateTime.now().month)
    {
      taskDone = true;
    }
    else if(keepSearching &&  int.parse(allNotes[i]
        .date
        .substring(3, 5)) ==
        DateTime.now().month)
    {keepSearching=true;
    }
    else{keepSearching=false;}
    if (keepSearching && int.parse(allNotes[i].date.substring(0,2))<DateTime.now().day){
      print(9<7);
      taskDone = true;
    }
    print(allNotes[i].toMap());
    return taskDone;
  }
}
