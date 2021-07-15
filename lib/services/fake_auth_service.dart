import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "117200105";
  @override
  Future<User> currentUser() async{
  return await Future.value(User(userID: userID, email: "fake email"));
  }

  @override
  Future<User> signInAnonyously() async{
    return await Future.delayed(Duration(seconds: 2), ()=>User(userID: userID, email: "fake email"));
  }

  @override
  Future<bool> signOut() {
   return Future.value(true);
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInGmail
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<User> createWithEmailAndPassword(String email, String password) {
    // TODO: implement createWithEmailAndPassword
    throw UnimplementedError();
  }

}