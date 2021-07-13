import 'package:flutter/material.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),
      actions: <Widget>[
        FlatButton(onPressed: ()=> _logOut(context), child: Text("Logout", style: TextStyle(color: Colors.white,fontSize: 20),))
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
}