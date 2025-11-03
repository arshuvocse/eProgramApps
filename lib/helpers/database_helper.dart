
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('main.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      category TEXT NOT NULL,
      price REAL NOT NULL,
      in_stock INTEGER NOT NULL
    )
    ''');

    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
    );

    await db.execute('''
    CREATE TABLE divisions (
      DivisionId INTEGER PRIMARY KEY,
      DivisionName TEXT NOT NULL
    )
    ''');
  }

  Future<int> saveUser(String username, String password) async {
    final dbClient = await database;
    await dbClient.delete('User'); // Clear previous user
    return await dbClient.insert('User', {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> getUser() async {
    final dbClient = await database;
    final result = await dbClient.query('User', limit: 1);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> deleteUser() async {
    final dbClient = await database;
    return await dbClient.delete('User');
  }
}
