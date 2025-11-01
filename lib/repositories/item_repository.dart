
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../helpers/database_helper.dart';
import '../models/item_model.dart';

class ItemRepository {
  Future<List<Item>> getItems() async {
    try {
      final response = await http.get(Uri.parse(AppConfig.baseUrl + ApiEndpoints.items));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Item> items = (data['rows'] as List)
            .map((itemJson) => Item.fromJson(itemJson))
            .toList();
        await _storeItemsInDb(items);
        return items;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      // If API fails, fetch from local DB
      return await _getItemsFromDb();
    }
  }

  Future<void> _storeItemsInDb(List<Item> items) async {
    final db = await DatabaseHelper.instance.database;
    for (var item in items) {
      await db.insert('items', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Item>> _getItemsFromDb() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        price: maps[i]['price'],
        inStock: maps[i]['in_stock'] == 1,
      );
    });
  }
}
