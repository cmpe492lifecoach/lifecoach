import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach_app/logInPage/email_password_page.dart';
import 'package:lifecoach_app/model/user_model.dart';
import 'package:lifecoach_app/services/auth_base.dart';
import 'package:lifecoach_app/services/firebase_auth_service.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'social_login_button.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text("Life Coach",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
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
            Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(height: 8,),//sign in nin altına 8px boşluk bırakır.
            SocialLogInButton(
              buttonText: "Google",
              buttonColor: Colors.white,
              textColor: Colors.black,
              //buttonIcon: Image.asset("images/images/icons8-google-48.png", width: 50, height: 50,),
              buttonIcon: Icon(Icons.outgoing_mail,
                size: 32,
                color: Colors.black,),
              onPressed: ()=> _googleWithEnter(context),
            ),
            SocialLogInButton(
              buttonText: "Facebook",
              textColor: Colors.white,
              radius: 16,
              buttonIcon: Image.asset("assets/facebook.png",color: Colors.white,),

              //buttonIcon: Icon(Icons.outgoing_mail,
              //size: 32,
              //color: Colors.white,),
              onPressed: () {},
              buttonColor: Color(0xFF334D92),
            ),
            SocialLogInButton(
              onPressed: () => _emailPasswordEntry(context),
              buttonText: "Email and Password",
              buttonIcon: Icon(Icons.email_sharp,
                size: 32,
                color: Colors.white,),
            ),
            SocialLogInButton(
              onPressed: ()=> _guestEntry(context),
              buttonColor: Colors.cyan,
              buttonText: "Guest Entry",
              buttonIcon: Icon(Icons.supervised_user_circle,
                size: 32,
                color: Colors.white,),
            ),
          ],

        ),
      ),
    );
  }


}


