import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pharmacy1/data/model/medicine_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = "myLocal.db";
  static const _databaseVersion = 1;
  static const table = "medicines";
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnPrice = 'price';
  static const columnCompany = 'company';
  static const columnNotes = 'notes';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } else {
      var databaseFactory = databaseFactoryFfi;
      Directory appDocDir = await getApplicationDocumentsDirectory();
      Directory dir = Directory("${appDocDir.path}/pharmacy");
      if (!await dir.exists()) {
        await dir.create();
      }
      String path = join(dir.path, _databaseName);
      return await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            version: _databaseVersion,
            onCreate: _onCreate,
          ));
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnName TEXT NOT NULL,
    $columnPrice TEXT NOT NULL,
    $columnCompany TEXT NOT NULL,
    $columnNotes TEXT 
  )
  ''');
  }

  Future<int> insert(MedicineModel medicine) async {
    Database? db = await instance.database;
    var res = await db!.insert(table, medicine.toJson());
    return res;
  }

  Future<int> update(MedicineModel medicine, String where) async {
    Database? db = await instance.database;
    var res = await db!.update(table, medicine.toJson(), where: where);
    var s = await queryAllRows();
    return res;
  }

  Future<List<MedicineModel>> queryAllRows(
      {where = "1=1", orderBy = "DESC"}) async {
    Database? db = await instance.database;
    List<MedicineModel> medicines = [];
    List<Map<String, Object?>> res =
        await db!.query(table, orderBy: "$columnId $orderBy", where: where);
    for (Map<String, Object?> r in res) {
      medicines.add(MedicineModel.fromJson(r));
    }
    return medicines;
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database? db = await instance.database;
    return await db!.rawQuery("DELETE FROM $table");
  }
}
