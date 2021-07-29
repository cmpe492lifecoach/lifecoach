import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';
import 'package:lifecoach_app/app/agenda_page/screens/home_page.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';

class MyBackButton extends StatelessWidget {
  final int pushPop;

 MyBackButton({this.pushPop});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
        child: GestureDetector(
        onTap: (){
          if (pushPop==1)Navigator.push(context,MaterialPageRoute(builder: (context)=>CalendarPage()));
          if(pushPop==2)Navigator.push(context,MaterialPageRoute(builder: (context)=>AgendaHomePage()));
        },
          child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: LightColors.kDarkBlue,
          ),
        ),
      ),
    );
  }
}