import 'package:flutter/material.dart';
import 'package:myapp/repositories/item_repository.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/helpers/database_helper.dart';

class SyncDataView extends StatefulWidget {
  const SyncDataView({super.key});

  @override
  State<SyncDataView> createState() => _SyncDataViewState();
}

class _SyncDataViewState extends State<SyncDataView> {
  bool _isSyncing = false;
  String _syncMessage = '';
  final ItemRepository _itemRepository = ItemRepository();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isSyncing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _syncData,
                    child: const Text('Sync Data'),
                  ),
            const SizedBox(height: 20),
            Text(_syncMessage),
          ],
        ),
      ),
    );
  }

  Future<void> _syncData() async {
    setState(() {
      _isSyncing = true;
      _syncMessage = 'Syncing data...';
    });

    try {
      final divisions = await _apiService.fetchDivisions();
      await _itemRepository.clearItems();
      for (var division in divisions) {
        final items = await _apiService.fetchItems(division);
        for (var item in items) {
          await _itemRepository.insertItem(item);
        }
      }
      final db = await DatabaseHelper().database;
      final localItems = await db.query('items');
      setState(() {
        _syncMessage = 'Sync completed successfully!\n';
        _syncMessage += '${localItems.length} items synced.';
      });
    } catch (e) {
      setState(() {
        _syncMessage = 'Error syncing data: $e';
      });
    }

    setState(() {
      _isSyncing = false;
    });
  }
}
