import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_work/model/model.dart';
const  String dbName = 'flutterWork.db';
const String music_table='music_table';

class SQLServer{
  //variables/////////////
 Database database;
 String  databasesPath ;
  String path ; 
/////////////////////////


  addLocalFile(ModelBase model)async{
    String tableName;
    switch (model.type) {
      case 'music':
      print('music!');
              tableName=music_table;
        break;
      default:break;
    }

    databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
   database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
      await db.execute(
      'CREATE TABLE $tableName (id INTEGER PRIMARY KEY,  title TEXT,path Text,modify Text,size Text)');
     });
     
     await database.transaction((txn) async {
       int id = await txn.rawInsert(
      'INSERT INTO $tableName(title, path,modify, size) VALUES("${model.title}", "${model.path}", "${model.modify}","${model.size}")');
    
}); 
  }
  
  Future<List> query()async{
    
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
    database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
      await db.execute(
      'CREATE TABLE music_table (id INTEGER PRIMARY KEY,  title TEXT,path Text,modify Text,size Text)');
     });
    List<Map> list = await database.rawQuery('SELECT * FROM music_table ');
    print('query:${list.length}');
    // print(list);
      return list;
  }

  clearTable()async{
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
    database=await openDatabase(path);
   int count = await database.rawDelete('DELETE FROM     music_table WHERE id > 0');
   
    
  }

 Future<int> queryCount()async{
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
    database=await openDatabase(path);
    List<Map> list = await database.rawQuery('SELECT * FROM music_table');
    print(list.length);
      return list.length;
  }

  
}