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
  bool isTaskDone=false;
  TaskContainer(
      {this.title, this.subtitle, this.boxColor, this.endTime, this.startTime,this.icon,this.category,this.color});

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
            Stack(
              children:[
                Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
               Container(
                 alignment: Alignment.centerRight,
                 child: Icon(
                    icon
                 ),
               ),
                /*Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '$date',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),*/
            ]),
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
            color: color,
            border: Border.all(color: Colors.black12,width: 2),
            borderRadius: BorderRadius.circular(30.0)),
      ),
      onTap: () {
        print("asdsad");
      },
    );
  }
  dateComparison(String date){
    bool keepSearching=true;
    if(int.parse(date.substring(0,4))>int.parse(DateTime.now().toString().substring(0,4))){
      isTaskDone=false;
    }
    else if(keepSearching&&int.parse(date.substring(4,6))>int.parse(DateTime.now().toString().substring(4,6))){
      isTaskDone=false;
    }
  }
}

