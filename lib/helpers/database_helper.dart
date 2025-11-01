
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'main.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(
          'CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
    );
  }

  Future<int> saveUser(String username, String password) async {
    final dbClient = await db;
    await dbClient!.delete('User'); // Clear previous user
    return await dbClient.insert('User', {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> getUser() async {
    final dbClient = await db;
    final result = await dbClient!.query('User', limit: 1);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> deleteUser() async {
    final dbClient = await db;
    return await dbClient!.delete('User');
  }
}
