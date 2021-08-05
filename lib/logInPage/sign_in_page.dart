import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach_app/logInPage/email_password_page.dart';
import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/services/auth_base.dart';
import 'package:lifecoach_app/services/firebase_auth_service.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import '../common_widget/social_login_button.dart';
import 'package:flutter/cupertino.dart';

import 'cantant_logIn.dart';
import 'create_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

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

            Text("Life Coach",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.greenAccent
              ),
            ),
            Image.asset(
              'Images/logo.jpeg',
              height: 320,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            )
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {




  void _guestEntry(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User _user =await _userModel.signInAnonyously();
    print("Sign In user ıd:" +_user.userID.toString());

  }
  void _googleWithEnter(BuildContext context) async{
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User _user =await _userModel.signInWithGoogle();
    if(_user != null)
      print("Sign In user ıd:" +_user.userID.toString());
  }
  void _emailPasswordEntry(BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(

      builder: (context) => EmailAndPasswordPage(),),);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Life Coach",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
        ),),
        elevation: 0,
      ),
      backgroundColor: Colors.white,


      body: Container(

        padding: EdgeInsets.all(20.0),
        child: Column(//column yukardan aşağı elemanlar sıralanır.

          mainAxisAlignment: MainAxisAlignment.center,//bunla ortadan başlatır.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'Images/logo.jpeg',
              height: 200,
            ),
            Text(
              "Log In",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.green),
            ),
            SizedBox(height: 70,),



            SizedBox(height: 10,),//sign in nin altına 8px boşluk bırakır.
            SocialLogInButton(
              onPressed: () => _emailPasswordEntry(context),
              buttonText: "Email and Password",
              height: 60,
              buttonColor: Colors.lightGreen,



            ),






            SocialLogInButton(

              onPressed: ()=> _guestEntry(context),
              buttonColor: Colors.cyan,
              buttonText: "Guest Entry",
              height: 60,

            ),
            SizedBox(height: 7,),
            Text(
              '-OR-',
              style: TextStyle(color: Colors.blue, fontSize: 15,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 7,),
            Text(
              'LogIn with',
              style: TextStyle(color: Colors.blue, fontSize: 15,),
              textAlign: TextAlign.center,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      onPressed: () => _googleWithEnter(context),),
                  ),
                  Expanded(
                    child: SignInButton.mini(
                        buttonType: ButtonType.google,
                      onPressed: () => _googleWithEnter(context),),
                  )
                ],
              ),
            )




          ],

        ),
      ),
    );
  }


}
