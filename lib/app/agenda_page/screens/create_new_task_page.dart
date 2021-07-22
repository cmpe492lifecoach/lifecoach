import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecoach_app/app/agenda_page/models/notes.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';
import 'package:lifecoach_app/app/agenda_page/utils/dbHelper.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/top_container.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/my_text_field.dart';
import 'package:lifecoach_app/app/agenda_page/screens/home_page.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/back_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
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
  final myController = TextEditingController();
  String myDate;

  @override
  void initState() {
    getNotes();
    print('Async done');
    super.initState();
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(pushPop: true,),
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
                            buildForm(_controllerTitle, "Başlık"),
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
                                border:
                                UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
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
                                focusedBorder:
                                UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),

                                hintStyle: TextStyle(),
                                hintText:
                                    selectedDate.toString().substring(0, 10)),
                          )),
                          IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today))
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: TextField(
                          enabled: false,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: _startTimeShow,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(7)),
                        alignment: Alignment.center,
                        width: 150,
                        height: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Select a Time',
                                          textAlign: TextAlign.start,
                                          style: (TextStyle(
                                            fontSize: 15.0,
                                          )),
                                        ),
                                        margin: EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          hourContainer(
                                              _startTimeHour, "hour", "24"),
                                          Container(
                                            child: Text(
                                              ':',
                                              textAlign: TextAlign.center,
                                              style: (TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w700)),
                                            ),
                                            width: 30,
                                          ),
                                          hourContainer(
                                              _startTimeMin, "min", "59")
                                        ],
                                      ),
                                      Container(
                                        child: TextButton(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text('OK',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          style: TextButton.styleFrom(
                                            primary: Colors.teal,
                                            onSurface: Colors.yellow,
                                            side: BorderSide(
                                                color: Colors.teal, width: 2),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                          ),
                                          onPressed: () {
                                            if (_startTimeHour.text == '') {
                                              Fluttertoast.showToast(
                                                  msg: "Enter a Hour",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity:
                                                      ToastGravity.CENTER_RIGHT,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (_startTimeMin.text ==
                                                '') {
                                              _startTimeMin.text = '00';
                                              Navigator.pop(context);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                            _startTimeShow =
                                                _startTimeHour.text +
                                                    ":" +
                                                    _startTimeMin.text;
                                          },
                                        ),
                                        margin: EdgeInsets.only(top: 5),
                                        alignment: Alignment.centerRight,
                                      )
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: TextField(
                          enabled: false,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: _endTimeShow,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(7)),
                        alignment: Alignment.center,
                        width: 150,
                        height: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          'Select a Time',
                                          textAlign: TextAlign.start,
                                          style: (TextStyle(
                                            fontSize: 15.0,
                                          )),
                                        ),
                                        margin: EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          hourContainer(
                                              _endTimeHour, "hour", "24"),
                                          Container(
                                            child: Text(
                                              ':',
                                              textAlign: TextAlign.center,
                                              style: (TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w700)),
                                            ),
                                            width: 30,
                                          ),
                                          hourContainer(
                                              _endTimeMin, "min", "59")
                                        ],
                                      ),
                                      Container(
                                        child: TextButton(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text('OK',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          style: TextButton.styleFrom(
                                            primary: Colors.teal,
                                            onSurface: Colors.yellow,
                                            side: BorderSide(
                                                color: Colors.teal, width: 2),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                          ),
                                          onPressed: () {
                                            if (_endTimeHour.text == '') {
                                              Fluttertoast.showToast(
                                                  msg: "Enter a Hour",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity:
                                                      ToastGravity.CENTER_RIGHT,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (_endTimeMin.text == '') {
                                              _endTimeMin.text = '00';
                                              Navigator.pop(context);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                            _endTimeShow = _endTimeHour.text +
                                                ":" +
                                                _endTimeMin.text;
                                          },
                                        ),
                                        margin: EdgeInsets.only(top: 5),
                                        alignment: Alignment.centerRight,
                                      )
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                      child: Column(children: <Widget>[
                    buildForm(_controllerDesc, "Description"),
                  ])),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            Chip(
                              label: Text("SPORT APP"),
                              backgroundColor: LightColors.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            Chip(
                              label: Text("MEDICAL APP"),
                            ),
                            Chip(
                              label: Text("RENT APP"),
                            ),
                            Chip(
                              label: Text("NOTES"),
                            ),
                            Chip(
                              label: Text("GAMING PLATFORM APP"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
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
                                SnackBar(content: Text('Task Saved')));
                            saveObject();
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>CalendarPage()));
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

  Widget buildForm(TextEditingController txtController, String str) {
    return Container(
        child: TextFormField(
      autofocus: false,
      controller: txtController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some title';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: str,
          labelStyle: TextStyle(color: Colors.black45),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    ));
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
      String myDate = selectedDate.toString().substring(0, 10);
      print(_startTimeShow + _endTimeShow);
      _addNote(Notes(_controllerTitle.text, _controllerDesc.text, myDate,
          _startTimeShow, _endTimeShow));
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
