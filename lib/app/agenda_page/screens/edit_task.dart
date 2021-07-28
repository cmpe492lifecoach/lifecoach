import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lifecoach_app/app/agenda_page/models/notes.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';
import 'package:lifecoach_app/app/agenda_page/utils/dbHelper.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/top_container.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/my_text_field.dart';
import 'package:lifecoach_app/app/agenda_page/screens/home_page.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/back_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/build_form.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatefulWidget {
  final int taskID;
  final int listID;

  EditTaskPage({this.listID, this.taskID});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  DateFormat newFormatter = DateFormat('HH-mm');
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int tag = 0;
  List<String> options = [
    'Sports',
    'Education',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Other'
  ];
  var _endTimeHour = TextEditingController();
  var _startTimeHour = TextEditingController();
  var _startTimeMin = TextEditingController();
  var _endTimeMin = TextEditingController();
  String _startTimeShow = 'Start Time';
  String _endTimeShow = 'End Time';
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Notes> allNotes = new List<Notes>();
  var _controllerTitle = TextEditingController();
  var _controllerDesc = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  int clickedNoteID;
  DateTime selectedDate = DateTime.now();
  String dateToShow;
  final myController = TextEditingController();
  bool startBool = false;
  bool endBool = false;
  bool checkedValue = false;

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    getNotes();

    dateToShow = formatter.format(selectedDate);
    super.initState();
  }

  void getNotes() async {
    var notesFuture = _databaseHelper.getAllNotes();
    await notesFuture.then((data) {
      setState(() {
        this.allNotes = data;
        if (allNotes == null) allNotes = [];
      });
    });
    _controllerTitle.text = allNotes[widget.listID].title;
    _controllerDesc.text = allNotes[widget.listID].description;
    dateToShow = allNotes[widget.listID].date;
    _startTimeShow=allNotes[widget.listID].startTime;
    _endTimeShow=allNotes[widget.listID].endTime;
    currentColor=Color(int.parse(allNotes[widget.listID].color.toString().substring(6,16)));


    for(int i=0;i<options.length;i++){
      if(allNotes[widget.listID].category==options[i])
        setState(() {
          tag=i;
        });
    }
    print("tag bu $tag");
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateToShow = formatter.format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(
                    pushPop: 1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Edit This Task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            BuildMyForm(
                                txtController: _controllerTitle, str: "Title"),
                          ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Date",
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                enabled: false,
                              ),
                            ),
                            width: 45,
                          ),
                          Expanded(
                              child: TextField(
                            textAlign: TextAlign.center,
                            onTap: () => _selectDate(context),
                            showCursor: false,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                hintStyle: TextStyle(),
                                hintText: dateToShow),
                          )),
                          IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today))
                        ],
                      )
                    ],
                  )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 150,
                      child: CheckboxListTile(
                        title: Text("Select Times"),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    checkedValue
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Platform.isIOS
                            ? Column(
                          children: [
                            Text("Start Time",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 100,
                              child: SizedBox(
                                height: 100,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    mode: CupertinoDatePickerMode
                                        .time,
                                    use24hFormat: true,
                                    onDateTimeChanged: (dateTime) =>
                                        setState(() {
                                          _startTimeShow =
                                              newFormatter
                                                  .format(dateTime);
                                        })),
                              ),
                            ),
                          ],
                        )
                            : GestureDetector(
                            child: Material(
                              borderRadius: BorderRadius.circular(11),
                              elevation: 15,
                              child: Container(
                                child: Text(
                                  _startTimeShow == ''
                                      ? "Start Time"
                                      : "Start Time : $_startTimeShow",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: ''),
                                ),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black38,
                                        width: 2),
                                    borderRadius:
                                    BorderRadius.circular(11)),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                startBool = true;
                              });
                              _timePickerForAndroid();
                            }),
                        Platform.isIOS
                            ? Column(
                          children: [
                            Text("End Time",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 100,
                              child: SizedBox(
                                height: 100,
                                child: CupertinoDatePicker(
                                    initialDateTime: DateTime.now(),
                                    mode: CupertinoDatePickerMode
                                        .time,
                                    use24hFormat: true,
                                    onDateTimeChanged: (dateTime) =>
                                        setState(() {
                                          _endTimeShow =
                                              newFormatter
                                                  .format(dateTime);
                                        })),
                              ),
                            ),
                          ],
                        )
                            : GestureDetector(
                            child: Material(
                              elevation: 15,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                child: Text(
                                  _endTimeShow == ''
                                      ? "End Time"
                                      : "End Time : $_endTimeShow",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: ''),
                                ),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black38,
                                        width: 2),
                                    borderRadius:
                                    BorderRadius.circular(11)),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                endBool = true;
                              });
                              _timePickerForAndroid();
                            }),
                      ],
                    )
                        : SizedBox(
                      height: 1,
                    ),
                    SizedBox(height: 10,),
                    Form(
                        child: Column(children: <Widget>[
                      BuildMyForm(
                        txtController: _controllerDesc,
                        str: "Description",
                      )
                    ])),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            )),
                        ChipsChoice<int>.single(
                          wrapped: true,
                          choiceStyle: C2ChoiceStyle(borderWidth: 2),
                          value: tag,
                          onChanged: (val) => setState(() => tag = val),
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: options,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        GestureDetector(
                            child: Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 170,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38,width: 2),
                                    borderRadius: BorderRadius.circular(11)
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Select Task Color",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                )
                            ),
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    titlePadding: const EdgeInsets.all(0.0),
                                    contentPadding: const EdgeInsets.all(0.0),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: currentColor,
                                        onColorChanged: changeColor,
                                        colorPickerWidth: 300.0,
                                        pickerAreaHeightPercent: 0.7,
                                        enableAlpha: true,
                                        displayThumbColor: true,
                                        showLabel: true,
                                        paletteType: PaletteType.hsv,
                                        pickerAreaBorderRadius: const BorderRadius.only(
                                          topLeft: const Radius.circular(2.0),
                                          topRight: const Radius.circular(2.0),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(() => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: currentColor,
                              shape: BoxShape.circle,
                              border:Border.all(color: Colors.black12,width: 2)
                          ),
                        )
                      ],
                    ),
                  ],

                ),
              ),
            )),
            Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Task Edited')));
                            updateTask();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalendarPage()));
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>CalendarPage()));
                          }
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: LightColors.kBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _timePickerForAndroid() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        if (startBool) {
          _startTimeShow = "${newTime.hour}:${newTime.minute}";
          if (newTime.hour.toString().length < 2)
            _startTimeShow = "0${newTime.hour}:${newTime.minute}";
          if (newTime.minute.toString().length < 2)
            _startTimeShow = "${newTime.hour}:0${newTime.minute}";
          if (newTime.minute.toString().length < 2 &&
              newTime.hour.toString().length < 2)
            _startTimeShow = "0${newTime.hour}:0${newTime.minute}";
        }
        if (endBool) {
          _endTimeShow = "${newTime.hour}:${newTime.minute}";
          if (newTime.hour.toString().length < 2)
            _endTimeShow = "0${newTime.hour}:${newTime.minute}";
          if (newTime.minute.toString().length < 2)
            _endTimeShow = "${newTime.hour}:0${newTime.minute}";
          if (newTime.minute.toString().length < 2 &&
              newTime.hour.toString().length < 2)
            _endTimeShow = "0${newTime.hour}:0${newTime.minute}";
        }
        startBool = false;
        endBool = false;
      });
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _updateNote(Notes note) async {
    await _databaseHelper.update(note);

    setState(() {
      getNotes();
      _controllerTitle.text = "";
      _controllerDesc.text = "";
    });
  }

  void updateTask() {
    if (widget.taskID != null) {
      _updateNote(Notes.withID(
          widget.taskID,
          _controllerTitle.text,
          _controllerDesc.text,
          dateToShow,
          _startTimeShow,
          _endTimeShow,
          options[tag],
          currentColor.toString()));
    } else {}
  }
}
