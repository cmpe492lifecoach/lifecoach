
import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/sports_page_extra/%C4%B1ntermadiate.dart';
import 'package:lifecoach_app/app/sports_page_extra/advanced.dart';
import 'package:lifecoach_app/app/sports_page_extra/beginner.dart';
import 'package:lifecoach_app/model/user.dart';



class YogaPage extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;


  const YogaPage({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,

  });

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Yoga'),
        centerTitle: true,
        actions: <Widget>[




        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Welcome Text
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "WELCOME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 46,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Please choose your level",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.green,
                  ),
                ),
              ),

              // Beginner Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    color: Colors.green,
                    onPressed: () {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> BeginnerPage())
                        );

                    },
                    child: Text(
                      'Beginner',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
              ),

              // Intermediate Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'Intermediate',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Intermediate())
                      );
                    },

                  ),
                ),
              ),

              // Advance Button
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    color: Colors.deepPurple,
                    child: Text(
                      'Advance',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Advanced())
                      );
                    },

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


