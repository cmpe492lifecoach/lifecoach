import 'package:flutter/material.dart';
import 'package:lifecoach_app/model/user.dart';
import 'package:lifecoach_app/viewmodel/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lifecoach_app/app/agenda_page/models/notes.dart';

class DatabaseHelper {
  static Database _database;

  String _notesTable = "notes";
  String _secondTable = "notes2";
  String _columnID = "id";
  String _columnTitle = "title";
  String _columnDescription = "description";
  String _columnDate="date";
  String _columnStartTime="startTime";
  String _columnEndTime="endTime";
  User _user;
  String tableName;
  bool databaseacildi=false;
  Future<Database> get database async {
    final _userModel = UserModel();
    _user = await _userModel.currentUser();
    tableName = "a" + _user.userID;
    print("burasigeldi");
    _database = await initializeDatabase();
    databaseacildi=true;
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "mytasks.db");
    var notesDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return notesDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $tableName($_columnID integer primary key, $_columnTitle text, $_columnDescription text,$_columnDate text,$_columnStartTime text,$_columnEndTime text)");
  }

  //Crud Methods
  Future<List<Notes>> getAllNotes() async {
    Database db = await this.database;
      await db.execute(
          "Create table if not exists $tableName($_columnID integer primary key, $_columnTitle text, $_columnDescription text,$_columnDate text,$_columnStartTime text,$_columnEndTime text)");
      var result2 = await db.query("$tableName");
      return List.generate(result2.length, (i) {
        return Notes.fromMap(result2[i]);
      });

  }

  Future<int> insert(Notes note) async {

   try{
     Database db = await this.database;
     var result = await db.insert("$tableName", note.toMap());
     return result;
   }
   catch(e){
     print("eklerken hata");

   }
   return null;


  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete("delete from $tableName where id=$id");
    return result;
  }

  Future<int> update(Notes note) async {
    Database db = await this.database;
    var result = await db.update("$tableName", note.toMap(),
        where: "id=?", whereArgs: [note.id]);
    return result;
  }
}
