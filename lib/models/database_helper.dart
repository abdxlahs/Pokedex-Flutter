import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'MyDatabase.db3';
  static final _dbVersion = 1;
  String _tableName = '';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    await _copyDbFromAssets(path);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _copyDbFromAssets(String path) async {
    ByteData data = await rootBundle.load(join('assets', _dbName));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<void> _onCreate(Database db, int version) async {}

  Future<List<Map<String, dynamic>>> fetchData(_tableName) async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  //custom query
   Future<List<Map<String, dynamic>>> customQuery(String query) async {
    Database db = await instance.database;
    return await db.rawQuery(query);
  }


  // Update the return type of customQueryWithArgs function
  Future<List<Map<String, dynamic>>> customQueryWithArgs(String query, List<dynamic> args) async {
    Database db = await instance.database;
    return await db.rawQuery(query, args);
  }

  Future<List<Map<String, dynamic>>> customQuerywithlistparameters(String query, [List<dynamic>? params]) async {
  Database db = await instance.database;
  return await db.rawQuery(query, params);
}



}
