import 'package:flutter/material.dart';
import 'package:lifecoach_app/common_widget/platform_alert_dialog.dart';
import 'package:lifecoach_app/common_widget/social_login_button.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController _controllerUserName;

  @override
  void initState() {
    // TODO: implement initState
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
   _controllerUserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.user.userName;
    print("Profilin bilgileri: "+_userModel.user.toString());

    return Scaffold(
      appBar: AppBar(title: Text("Profile"),
      actions: <Widget>[
        FlatButton(
            onPressed: ()=> _approveLogOut(context),
            child: Text("Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),))
      ],
      ),
      body: SingleChildScrollView(//kaydırmalı widget
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.black,
                 // backgroundImage: NetworkImage(_userModel.user.profilURL),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userModel.user.email,
                  readOnly: true,//false yaparsan günceller.
                  decoration: InputDecoration(
                    labelText: "Your Email",
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,

                  decoration: InputDecoration(
                    labelText: "Your Username",
                    hintText: "User Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SocialLogInButton(
                  buttonText: "Save",

                  buttonColor: Colors.green,
                  onPressed: (){
                        _userNameUpdate(context);
                  },
                ),
              )

            ],
          ),
        ),

    )
    );

  }

  Future<bool> _logOut(BuildContext context) async{
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userModel.signOut();
    return result;
  }

  Future _approveLogOut(BuildContext context) async{
    final result = await PlatformAlertDialog(
      header: "Are You Sure??",
      content: "Are you sure to log out?",
      mainButtonText: "Yes",
      closeButtonText: "No",
    ).show(context);

    // ignore: unrelated_type_equality_checks
    if(result==true){
      _logOut(context);
    }
  }

  void _userNameUpdate(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if(_userModel.user.userName != _controllerUserName.text){
     // _userModel.updateUserName(_controllerUserName.text);
    }else
      {
        PlatformAlertDialog(
          header: "Error!",
          content: "Do not change Username",
          mainButtonText: 'Okay',
        ).show(context);
      }
  }
}