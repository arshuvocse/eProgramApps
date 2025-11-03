
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import '../helpers/database_helper.dart';
import '../models/division_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/app_config.dart';
import '../config/api_endpoints.dart';

class SyncDataView extends StatefulWidget {
  const SyncDataView({super.key});

  @override
  State<SyncDataView> createState() => _SyncDataViewState();
}

class _SyncDataViewState extends State<SyncDataView> {
  @override
  void initState() {
    super.initState();
    _syncData();
  }

  Future<void> _syncData() async {
    try {
      await _fetchAndSaveDivisions();
      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error syncing data: $e')),
        );
        // Optionally, navigate to an error page or back to the login page
        context.go('/login');
      }
    }
  }

  Future<void> _fetchAndSaveDivisions() async {
    final response = await http.get(Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.divisions}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Division> divisions = data.map((json) => Division.fromJson(json)).toList();
      await _saveDivisionsToDb(divisions);
    } else {
      throw Exception('Failed to load divisions');
    }
  }

  Future<void> _saveDivisionsToDb(List<Division> divisions) async {
    final db = await DatabaseHelper.instance.database;
    final batch = db.batch();

    // Clear existing data before inserting new data
    batch.delete('divisions');

    for (var division in divisions) {
      batch.insert('divisions', division.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Syncing data, please wait...'),
          ],
        ),
      ),
    );
  }
}
