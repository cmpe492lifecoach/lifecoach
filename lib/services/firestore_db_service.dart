import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifecoach_app/model/user_model.dart';

import 'database_base.dart';

class FireStoreDBService implements DataBase {

  final Firestore _firebaseAuth = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async{ //user ı map e dönüştürüp firebase e sunuyoruz.


    await _firebaseAuth
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

}