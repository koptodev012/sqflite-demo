import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  Database? database;

  //! Create database in local storage (Mobile Storage)

  Future<Database?> get databaseFunction async {
    if (database != null) {
      return database;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE DatabaseTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age INTEGER
        )
        
        ''');
      },
    );

    return database;
  }

  //! Insert Data

  insertData() async {
    Database? db = await databaseFunction;

    Map<String, dynamic> data = {'name': 'Rohit', 'age': 24};

    db?.insert('DatabaseTable', data);
    log("Data inserted");
  }

  //! Read Data

  readData() async {
    Database? db = await databaseFunction;
    final dataList = await db?.query('DatabaseTable');
    log("Data Read");
    return dataList;
  }
}
