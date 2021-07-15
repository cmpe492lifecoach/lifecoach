import 'package:flutter/material.dart';
import 'package:lifecoach_app/common_widget/platform_alert_dialog.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Center(child: Text("Profile Page"),),
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
}