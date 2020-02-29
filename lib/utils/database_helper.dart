import 'package:calculator/models/calculation_result.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String calculationResultTable = 'calculationResult_table';
  String colId = 'id';
  String colNumber = 'number';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'calculationResults.db';

    var calculationResultsDatabase = await openDatabase(path, version: 2, onCreate: _createDb);
    return calculationResultsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $calculationResultTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNumber TEXT)');
  }

  Future<int> insertCalculationResult(CalculationResult value) async {
    Database db = await this.database;
    int result = await db.insert(calculationResultTable, value.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> readData() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT * from $calculationResultTable');
    print(x);
    return x;
  }

}