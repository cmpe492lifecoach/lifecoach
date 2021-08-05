import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach_app/home_page.dart';
import 'package:lifecoach_app/locator.dart';
import 'package:lifecoach_app/logInPage/sign_in_page.dart';
import 'package:lifecoach_app/services/auth_base.dart';
import 'package:lifecoach_app/services/firebase_auth_service.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';


class LandingPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final _userModel = Provider.of<UserModel>(context);

    if(_userModel.state == ViewState.Idle){
      if(_userModel.user == null){
        return SignInPage();
      }else{
        return HomePage(user: _userModel.user);//HomePage(user: _userModel.user);
      }
    }else{
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }


  }


}
