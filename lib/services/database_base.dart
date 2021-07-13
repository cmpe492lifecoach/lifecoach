import 'package:lifecoach_app/model/user_model.dart';

abstract class DataBase {
  Future<bool> saveUser(User user);
}