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

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
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
  String _startTimeShow = '';
  String _endTimeShow = '';
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Notes> allNotes = new List<Notes>();
  var _controllerTitle = TextEditingController();
  var _controllerDesc = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  int clickedNoteID;
  DateTime selectedDate = DateTime.now();
  final myController = TextEditingController();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  String myDate;
  bool startBool = false;
  bool endBool = false;
  bool checkedValue = false;

  @override
  void initState() {
    getNotes();
    print('Async done');
    myDate = formatter.format(selectedDate);
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
        myDate = formatter.format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                        'Create new task',
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
                                hintText: myDate),
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
                                  ?   Column(
                                    children: [
                                      Text("Start Time"),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 100,
                                        child: SizedBox(
                  height: 100,
                  child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (dateTime) => setState(() {
                          _startTimeShow = newFormatter.format(dateTime);

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
                                  ? GestureDetector(
                                      child: Column(
                                        children: [
                                          Text("End Time"),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 100,
                                            child: SizedBox(
                                              height: 100,
                                              child: CupertinoDatePicker(
                                                  initialDateTime: DateTime.now(),
                                                  mode: CupertinoDatePickerMode.time,
                                                  use24hFormat: true,
                                                  onDateTimeChanged: (dateTime) => setState(() {
                                                    _endTimeShow = newFormatter.format(dateTime);

                                                  })),
                                            ),
                                          ),
                                        ],
                                      )
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
                            height: 0,
                          ),
                    SizedBox(
                      height: 10,
                    ),
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
                                width: 150,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black38, width: 2),
                                    borderRadius: BorderRadius.circular(11)),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Select Task Color",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                )),
                            onTap: () {
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
                                        pickerAreaBorderRadius:
                                            const BorderRadius.only(
                                          topLeft: const Radius.circular(2.0),
                                          topRight: const Radius.circular(2.0),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(
                                              () => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: currentColor,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black12, width: 2)),
                        )
                      ],
                    ),
                    GestureDetector(
                      child: Text("bas"),
                      onTap: () =>
                          print(currentColor.toString().substring(6, 16)),
                    )
                  ],
                ),
              ),
            )),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Task Saved')));
                      saveObject();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage()));
                    }
                  },
                  child: Text(
                    'Create Task',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
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
    );
  }

  // Widget buildForm(TextEditingController txtController, String str) {
  //   return Container(
  //       child: TextFormField(
  //     autofocus: false,
  //     controller: txtController,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter some title';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //         labelText: str,
  //         labelStyle: TextStyle(color: Colors.black45),
  //         focusedBorder:
  //             UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  //         border:
  //             UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
  //   ));
  // }

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

   Widget timePicker() {
    SizedBox(
      height: 100,
      child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          onDateTimeChanged: (dateTime) => setState(() {
                if (startBool) _startTimeShow = newFormatter.format(dateTime);
                if (endBool) _endTimeShow = newFormatter.format(dateTime);
              })),
    );
  }

  Widget hourContainer(
      TextEditingController txtController, String str, String limit) {
    return Container(
      child: Form(
          child: TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String value) {
          if (int.parse(value) > int.parse(limit)) {
            txtController.text = limit;
          }
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
            hintText: str,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
        controller: txtController,
      )),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(10),
      width: 100,
    );
  }

  Widget buildButton(String str, Color buttonColor, Function eventFunc) {
    return RaisedButton(
      child: Text(str),
      color: buttonColor,
      onPressed: () {
        eventFunc();
      },
    );
  }

  void saveObject() {
    if (_formKey.currentState.validate()) {
      _addNote(Notes(_controllerTitle.text, _controllerDesc.text, myDate,
          _startTimeShow, _endTimeShow, options[tag], currentColor.toString()));
    }
  }

  void _addNote(Notes note) async {
    await _databaseHelper.insert(note);

    setState(() {
      getNotes();
      _startTimeShow = 'Pick a Time';
      _endTimeShow = 'Pick a Time';
      _startTimeHour.text = '';
      _startTimeMin.text = '';
      _endTimeHour.text = '';
      _endTimeMin.text = '';
      _controllerTitle.text = "";
      _controllerDesc.text = "";
    });
  }
}
