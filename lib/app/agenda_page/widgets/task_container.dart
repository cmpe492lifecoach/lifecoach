import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color boxColor;
  final String endTime;
  final String startTime;
  final IconData icon;
  final Color color;
  final String category;
  bool isTaskDone = false;

  TaskContainer(
      {this.title,
      this.subtitle,
      this.boxColor,
      this.endTime,
      this.startTime,
      this.icon,
      this.category,
      this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

            Stack(children: [
              Icon(Icons.chevron_right),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 25),
                child: Text(
                  subtitle!=' '?
                  subtitle
                  :'No Description',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 33),
                alignment: Alignment.centerRight,
                child: Icon(icon),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_left),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 25),
              child: Text(
                startTime!=''&& endTime!=''?
                '$startTime - $endTime'
                :'',
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
            color: color,
            border: Border.all(color: Colors.black12, width: 2),
            borderRadius: BorderRadius.circular(30.0)),
      ),
      onTap: () {
        print("asdsad");
      },
    );
  }

  dateComparison(String date) {
    bool keepSearching = true;
    if (int.parse(date.substring(0, 4)) >
        int.parse(DateTime.now().toString().substring(0, 4))) {
      isTaskDone = false;
    } else if (keepSearching &&
        int.parse(date.substring(4, 6)) >
            int.parse(DateTime.now().toString().substring(4, 6))) {
      isTaskDone = false;
    }
  }
}
