import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:myapp/models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User(
        UserId INTEGER PRIMARY KEY,
        EmpInfoId INTEGER,
        UserName TEXT,
        EmpMasterCode TEXT,
        UserType TEXT,
        LoginName TEXT,
        Password TEXT,
        UserEmail TEXT,
        ContactInfo TEXT,
        UserCo TEXT,
        RoleTypeId INTEGER,
        IsApprove INTEGER,
        IsForward INTEGER,
        RoleType TEXT,
        IsImeiMatched INTEGER,
        VersionName TEXT,
        ShiftStartTime TEXT,
        ShiftEndTime TEXT,
        IsTrackEnable INTEGER,
        EmpRole TEXT,
        DesigName TEXT,
        TwoDeviceMsg TEXT
      )
    ''');
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'User',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser() async {
    final db = await database;
    final maps = await db.query('User');
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
