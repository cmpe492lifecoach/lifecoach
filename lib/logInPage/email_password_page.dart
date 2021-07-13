import 'package:flutter/material.dart';
import 'package:lifecoach_app/logInPage/social_login_button.dart';
import 'package:lifecoach_app/model/user_model.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum FormType {Register, LogIn}

class EmailAndPasswordPage extends StatefulWidget {
  @override
  _EmailAndPasswordPageState createState() => _EmailAndPasswordPageState();
}

class _EmailAndPasswordPageState extends State<EmailAndPasswordPage> {
  String _email, _password;
  String _buttonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();
  void _formSubmit() async{
    _formKey.currentState.save();
    debugPrint("Email: "+_email + " Password: "+_password);
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if(_formType == FormType.LogIn){
        User _loginUser = await _userModel.signInWithEmailAndPassword(_email, _password);
        if(_loginUser != null)
          print("user ıd:" +_loginUser.userID.toString());
    }else {
      User _createUser = await _userModel.createWithEmailAndPassword(_email, _password);
      if(_createUser != null)
        print("user ıd:" +_createUser.userID.toString());
    }

  }

  void _change() {
          setState(() {
            _formType = _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
          });
  }

  @override
  Widget build(BuildContext context) {

_buttonText = _formType == FormType.LogIn ? "Sign In" : "Sign Up";
_linkText = _formType == FormType.LogIn ? "Is there any account ? Please Sign Up" : "Sign In Please";

final _userModel = Provider.of<UserModel>(context);

if(_userModel.user != null){
  Future.delayed(Duration(microseconds: 10), () {
    Navigator.of(context).pop();
  });

}

    return Scaffold(
        appBar: AppBar(
          title: Text("Email and Password"),),
        body: _userModel.state == ViewState.Idle ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: _userModel.emailErrorMessage != null ? _userModel.emailErrorMessage : null,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String enterEmail) {
                    _email = enterEmail;
                  },
                ),

                SizedBox(height: 8,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _userModel.passwordErrorMessage != null ? _userModel.passwordErrorMessage : null,
                    prefixIcon: Icon(Icons.admin_panel_settings),
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String enterPassword) {
                    _password = enterPassword;
                  },
                ),
                SizedBox(height: 8,),
                SocialLogInButton(
                  buttonText: _buttonText,
                  buttonColor: Theme
                      .of(context)
                      .primaryColor,
                  buttonIcon: Icon(Icons.ad_units),
                  radius: 10,
                  onPressed: () => _formSubmit(),
                ),
                SizedBox(height: 10,),
                FlatButton(onPressed: () => _change(),
                 child: Text(_linkText))

              ],
            )),
          ),
        ) : Center(child: CircularProgressIndicator(),)
    );
  }




}




