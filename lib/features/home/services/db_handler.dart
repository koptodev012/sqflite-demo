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

  insertData(String name, int age) async {
    Database? db = await databaseFunction;

    Map<String, dynamic> data = {'name': name, 'age': age};

    db?.insert('DatabaseTable', data);
    log("Data inserted name: $name age: $age");
  }

  //! Read Data

  readData() async {
    Database? db = await databaseFunction;
    final dataList = await db?.query('DatabaseTable');
    log("Data Read");
    return dataList;
  }

  //! Delete Data

  deleteData(int id) async {
    Database? db = await databaseFunction;
    await db?.delete('DatabaseTable', where: 'id = ?', whereArgs: [id]);
    log("Data Deleted id: $id");
  }

  //! Update Data

  updateData(int id, String name, int age) async {
    Database? db = await databaseFunction;
    Map<String, dynamic> data = {'name': name, 'age': age};
    await db?.update('DatabaseTable', data, where: 'id = ?', whereArgs: [id]);
    log("Data Updated id $id --> name: $name age: $age");
  }
}
