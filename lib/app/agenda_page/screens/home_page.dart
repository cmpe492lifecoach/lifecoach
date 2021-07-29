import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/agenda_page/screens/calendar_page.dart';
import 'package:lifecoach_app/app/agenda_page/utils/dbHelper.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/task_column.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/active_project_card.dart';
import 'package:lifecoach_app/app/agenda_page/widgets/top_container.dart';
import 'package:lifecoach_app/app/colors/light_colors.dart';

class AgendaHomePage extends StatelessWidget {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 120,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      heightFactor: 1.6,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: CircularPercentIndicator(
                                  radius: 72.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: 0.7,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: LightColors.kRed,
                                  backgroundColor: Colors.transparent,
                                  center: CircleAvatar(
                                    backgroundColor: LightColors.kBlue,
                                    radius: 30.0,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ]),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                              indent: 0,
                              endIndent: 2,
                              width: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Oğuzhan Kıdık',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: LightColors.kDarkBlue,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('My Tasks'),
                              GestureDetector(
                                onTap: () {
                                   var _dbHelper= new DatabaseHelper();
                                   _dbHelper.getAllNotes();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalendarPage()),
                                  );
                                },
                                child: calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: 'To Do',
                            subtitle: '5 tasks now. 1 started',
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'In Progress',
                            subtitle: '1 tasks now. 1 started',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check_circle_outline,
                            iconBackgroundColor: LightColors.kBlue,
                            title: 'Done',
                            subtitle: '18 tasks now. 13 started',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Active Projects'),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: 'Medical App',
                                subtitle: '9 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kRed,
                                loadingPercent: 0.6,
                                title: 'Making History Notes',
                                subtitle: '20 hours progress',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kDarkYellow,
                                loadingPercent: 0.45,
                                title: 'Sports App',
                                subtitle: '5 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kBlue,
                                loadingPercent: 0.9,
                                title: 'Online Flutter Course',
                                subtitle: '23 hours progress',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
