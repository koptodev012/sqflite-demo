import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/features/home/model/model_class.dart';

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

  insertData(ModelClass modelclass) async {
    Database? db = await databaseFunction;

    db?.insert('DatabaseTable', modelclass.toMap());
    log("Data inserted name: ${modelclass.name} age: ${modelclass.age}");
  }

  //! Read Data

  Future<List<ModelClass>> readData() async {
    Database? db = await databaseFunction;
    final dataList = await db?.query('DatabaseTable');
    log("Data Read");
    return dataList!.map((e) => ModelClass.fromMap(e)).toList();
  }

  //! Delete Data

  deleteData(int id) async {
    Database? db = await databaseFunction;
    await db?.delete('DatabaseTable', where: 'id = ?', whereArgs: [id]);
    log("Data Deleted id: $id");
  }

  //! Update Data

  updateData(ModelClass modelclass) async {
    Database? db = await databaseFunction;

    await db?.update('DatabaseTable', modelclass.toMap(),
        where: 'id = ?', whereArgs: [modelclass.id]);
    log("Data Updated id ${modelclass.id} --> name: ${modelclass.name} age: ${modelclass.age}");
  }
}
