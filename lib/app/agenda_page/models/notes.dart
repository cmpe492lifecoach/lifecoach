

import 'package:flutter/material.dart';

class Notes {
  int id;
  String title;
  String description;
  String date;
  String startTime;
  String endTime;
  String category;
  String color;

  Notes(this.title, this.description,this.date,this.startTime,this.endTime,this.category,this.color); // Constructor'ımızı oluşturduk.

  Notes.withID(this.id, this.title, this.description,this.date,this.startTime,this.endTime,this.category,this.color);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["date"]=date;
    map["startTime"]=startTime;
    map["endTime"]=endTime;
    map["category"]=category;
    map["color"]=color;
    return map; //
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
    this.date=map["date"];
    this.startTime=map["startTime"];
    this.endTime= map["endTime"];
    this.category=map["category"];
    this.color=map["color"];
  }
}
