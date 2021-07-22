import 'package:flutter/material.dart';


class TaskContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color boxColor;
  final String endTime;
  final String startTime;
  TaskContainer({
    this.title, this.subtitle, this.boxColor,this.endTime,this.startTime
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '$startTime - $endTime',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(30.0)),
      ),
      onTap: (){
        print("asdsad");
      },
    );
  }
}