import 'package:lifecoach_app/model/user.dart';

abstract class AuthBase{
  Future<User> currentUser();
  Future<User> signInAnonyously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createWithEmailAndPassword(String email, String password);

}