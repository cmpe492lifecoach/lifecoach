import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';

class CalendarDates extends StatefulWidget {
  final String day;
  final String date;
  final Color dayColor;
  final Color dateColor;
  CalendarDates({this.day, this.date, this.dayColor, this.dateColor});
  @override
  _CalendarDatesState createState() => _CalendarDatesState();

}

class _CalendarDatesState extends State<CalendarDates> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextButton(
              child: Text(
                widget.day,
                style:
                  pressed
                      ? TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w400)
                      : TextStyle(fontSize: 16, color:widget.dayColor, fontWeight: FontWeight.w400),

              ),
              onPressed: () {
                var calendarPage=new CalendarPageState();

                print(widget.day);
                setState(() {
                  pressed = !pressed;
                  calendarPage.saa=widget.day;
                });
              }),
          height: 31,
          width: 50,
        ),
        Container(
          child: TextButton(
            child: Text(
              widget.date,
              style: TextStyle(
                  fontSize: 16, color: widget.dateColor, fontWeight: FontWeight.w700),
            ),
          ),
          height: 31,
          width: 45,
        ),
      ],
    );
  }

}
