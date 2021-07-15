import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class User {
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime updatedAt;
  int level;
  String weight;
  String height;
  String afterBeforePhoto;

  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() { // toMap() ile sınıftaki adları firebase e kaydeder.
    return {
      'userID' : userID, //'userID'---> firebase e kaydedilecek değerler. userID--> sınıfımızdaki değerler
      'email' : email ?? '',
      'userName' : userName ??  email.substring(0, email.indexOf('@')) + randomGenerateNumber(),
      'profilURL' : profilURL ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt' : updatedAt ?? FieldValue.serverTimestamp(),
      'level' : level ?? 1,
      'weight' : weight ?? '',
      'height' : height ?? '',
      'afterBeforePhoto' : afterBeforePhoto ?? '',

    };
  }

  User.fromMap(Map<String, dynamic> map) :
        userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        level = map['level'],
        weight = map['weight'],
        height = map['height'],
        afterBeforePhoto = map['afterBeforePhoto'];

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, level: $level, weight: $weight, height: $height, afterBeforePhoto: $afterBeforePhoto}';
  }
//username oluşturulurken uniq olması için yanına koyulan random sayı methodu.
  String randomGenerateNumber() {
    int randomNumber = Random().nextInt(999999);
    return randomNumber.toString();
  }
}