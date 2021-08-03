import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController _controllerHeight;
  File _profilePhoto;
  final ImagePicker _picker = ImagePicker();

  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    _controllerUserName = TextEditingController();
    _controllerHeight = TextEditingController();
  }

  @override
  void dispose() {
   _controllerUserName.dispose();
   _controllerHeight.dispose();
    super.dispose();

  }


  void _choosePhoto(ImageSource source) async{
    var _pickedFoto = await _picker.getImage(source: source);
    setState(() {
      _profilePhoto = File(_pickedFoto.path);
      Navigator.of(context).pop();
    });
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
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (context){
                      return Container(
                        height: 230,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text("Shoot from camera"),
                              onTap: () => _choosePhoto(ImageSource.camera),
                            ),
                            ListTile(
                              leading: Icon(Icons.image),
                              title: Text("Choose Photo in Galery"),
                              onTap: () => _choosePhoto(ImageSource.gallery),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/avatar.png')
                  ),
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
                   readOnly: false,
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

  void _userNameUpdate(BuildContext context) async{
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if(_userModel.user.userName != _controllerUserName.text){
      var updateResult = await _userModel.updateUserName(_userModel.user.userID, _controllerUserName.text);
      if(updateResult == true){

        PlatformAlertDialog(
          header: "Successful",
          content: "Username changed",
          mainButtonText: 'Okay',
        ).show(context);
      }else {
            _controllerUserName.text = _userModel.user.userName;
        PlatformAlertDialog(
          header: "Error",
          content: "Username does not change",
          mainButtonText: 'Okay',
        ).show(context);
      }

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