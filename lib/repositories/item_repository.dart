import 'package:myapp/helpers/database_helper.dart';
import 'package:myapp/models/item_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemRepository {
  final dbHelper = DatabaseHelper();

  Future<void> insertItem(Item item) async {
    final db = await dbHelper.database;
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> getItems() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return Item.fromJson(maps[i]);
    });
  }

  Future<void> clearItems() async {
    final db = await dbHelper.database;
    await db.delete('items');
  }

  Future<List<Item>> getItemsForDivision(String division) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'division = ?',
      whereArgs: [division],
    );
    return List.generate(maps.length, (i) {
      return Item.fromJson(maps[i]);
    });
  }
}
