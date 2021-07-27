import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifecoach_app/model/user.dart';

import 'database_base.dart';

class FireStoreDBService implements DataBase {

  final Firestore _firebaseDB = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async{ //user ı map e dönüştürüp firebase e sunuyoruz.


    await _firebaseDB
        .collection("users")
        .document(user.userID)
        .setData(user.toMap());
     //KAYDEDİLEN VERİLERİN OKUNMASI
    //firestore da ki dataları okuma işlemi
    DocumentSnapshot _readUser = await Firestore.instance.document("users/${user.userID}").get();
    Map _readingUserInfo = _readUser.data;
    User _readingUserInfoObject = User.fromMap(_readingUserInfo);
    print("Reading User Information: " +_readingUserInfoObject.toString());

    return true;
  }

  @override
  Future<User> readUser(String userID) async{
    DocumentSnapshot _readUser = await _firebaseDB.collection("users").document(userID).get();
    Map<String, dynamic> _readUserInfoMap = _readUser.data;
    User _readUserObject = User.fromMap(_readUserInfoMap);
    print("Read user object : " +_readUserObject.toString());
    return _readUserObject;
  }

  @override
  Future<bool> updateUserName(String userID, String newUserName) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }

}