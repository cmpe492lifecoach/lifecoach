import 'package:lifecoach_app/model/user.dart';

abstract class DataBase {
  Future<bool> saveUser(User user);
  Future<User> readUser(String userID);
  Future<bool> updateUserName(String userID, String newUserName);
  Future<bool> updateHeight(String userID, String newHeight);


}