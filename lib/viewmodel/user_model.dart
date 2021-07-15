import 'package:flutter/material.dart';
import 'package:lifecoach_app/locator.dart';
import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/repository/user_repository.dart';
import 'package:lifecoach_app/services/auth_base.dart';

enum ViewState {Idle, Busy}

class UserModel with ChangeNotifier implements AuthBase{
ViewState _state = ViewState.Idle;
Repository _repository = locator<Repository>();
User _user;
String emailErrorMessage;
String passwordErrorMessage;


User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User> currentUser() async{
    try{
      state=ViewState.Busy;
      _user = await _repository.currentUser();
      return _user;
    }catch(e){
      debugPrint("ViewModel Current User Error!!!" +e.toString());
      return null;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInAnonyously() async{
    try{
      state=ViewState.Busy;
      _user = await _repository.signInAnonyously();
      return _user;
    }catch(e){
      debugPrint("ViewModel Current User Error!!!" +e.toString());
      return null;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithGoogle() async{
    try{
      state=ViewState.Busy;
      _user = await _repository.signInWithGoogle();
      return _user;
    }catch(e){
      debugPrint("ViewModel Current User Error!!!" +e.toString());
      return null;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async{
    try{
      state=ViewState.Busy;
      bool result = await _repository.signOut();
      _user = null;
      return result;

    }catch(e){
      debugPrint("ViewModel Current User Error!!!" +e.toString());
      return false;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    try{
      if(_emailPasswordControl(email, password)){
        state=ViewState.Busy;
        _user = await _repository.signInWithEmailAndPassword(email, password);
        return _user;
      }else return null;


    }catch(e){
      debugPrint("ViewModel SignInWithEmailAndPassword User Error!!!" +e.toString());
      return null;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> createWithEmailAndPassword(String email, String password) async{

      if(_emailPasswordControl(email, password)){

        try{
          state=ViewState.Busy;
          _user = await _repository.createWithEmailAndPassword(email, password);

          return _user;
        }finally{
          state = ViewState.Idle;
        }
      }else return null;

  }

  bool _emailPasswordControl(String email, String password){
    var result = true;

    if(password.length < 6){
      passwordErrorMessage = "Min 6 Character must be!!!";
      result = false;
    }else passwordErrorMessage = null;
    if(!email.contains('@')){
      emailErrorMessage = "please write correct email address";
      result = false;
    }else emailErrorMessage = null;



    return result;
  }


}