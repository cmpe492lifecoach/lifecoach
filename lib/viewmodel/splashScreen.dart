import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifecoach_app/logInPage/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SignInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Life Coach", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60,
              color: Colors.green,
            ),),
            SizedBox(height: 8,),
            // logo here
            Image.asset(
              'Images/logo.jpeg',
              height: 220,

            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            )
          ],
        ),
      ),
    );
  }
}