import 'package:flutter/cupertino.dart';
import 'package:lifecoach_app/locator.dart';
import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/services/auth_base.dart';
import 'package:lifecoach_app/services/fake_auth_service.dart';
import 'package:lifecoach_app/services/firebase_auth_service.dart';
import 'package:lifecoach_app/services/firestore_db_service.dart';


enum AppMode {DEBUG, RELEASE}

class Repository implements AuthBase{

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService = locator<FakeAuthenticationService>();
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();

  AppMode appMode = AppMode.RELEASE; //firebase daha ayarlanmamış.

  @override
  Future<User> currentUser() async{
   if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.currentUser();
   }else {
     return await _firebaseAuthService.currentUser();
   }
  }

  @override
  Future<User> signInAnonyously() async{
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInAnonyously();
    }else {
      return await _firebaseAuthService.signInAnonyously();
    }
  }

  @override
  Future<bool> signOut() async{
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signOut();
    }else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User> signInWithGoogle() async{
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithGoogle();
    }else {
      return await _firebaseAuthService.signInWithGoogle();
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithEmailAndPassword(email, password);
    }else {
      try{
        User _user = await _firebaseAuthService.signInWithEmailAndPassword(email, password);
        return await _fireStoreDBService.readUser(_user.userID);
      }catch(e){
        debugPrint("SignInWirhEmailAndPassword Repo Error :" +e.toString());
      }
    }
  }

  @override
  Future<User> createWithEmailAndPassword(String email, String password) async{
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.createWithEmailAndPassword(email, password);
    }else {

        User _user = await _firebaseAuthService.createWithEmailAndPassword(email, password);
        bool _result = await _fireStoreDBService.saveUser(_user);
        if(_result){

          return await _fireStoreDBService.readUser(_user.userID);
        }else return null;

    }
  }

}