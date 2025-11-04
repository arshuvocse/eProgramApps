import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../config/app_config.dart';
import '../config/api_endpoints.dart';
import '../models/item_model.dart';

class ApiService {
  Future<Map<String, String>> _getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? imei;
    String? deviceToken; // This should be handled by a push notification service
    String? device;
    String? appVersion = '1.0.0'; // You can get this from pubspec.yaml
    String? os;
    String? osVersion;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      imei = androidInfo.id;
      device = androidInfo.model;
      os = 'Android';
      osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      imei = iosInfo.identifierForVendor;
      device = iosInfo.utsname.machine;
      os = 'iOS';
      osVersion = iosInfo.systemVersion;
    }

    return {
      'Imei': imei ?? '',
      'DeviceToken': deviceToken ?? 'dummy_token', // Replace with actual token
      'Device': device ?? '',
      'AppVersion': appVersion,
      'OS': os ?? '',
      'OS_Version': osVersion ?? '',
    };
  }

  Future<http.Response> login(String username, String password) async {
    final deviceDetails = await _getDeviceDetails();
    final queryParams = {
      'UserName': username,
      'password': password,
      ...deviceDetails,
    };

    final uri = Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.login}')
        .replace(queryParameters: queryParams);

    return await http.post(uri);
  }

  Future<List<String>> fetchDivisions() async {
    // This is a placeholder. Replace with actual API call.
    return Future.value(['Division A', 'Division B']);
  }

  Future<List<Item>> fetchItems(String division) async {
    // This is a placeholder. Replace with actual API call.
    await Future.delayed(const Duration(seconds: 1)); // Simulate network latency
    final items = [
      Item(id: 1, name: 'Item 1', category: 'Category 1', price: 10.0, inStock: true),
      Item(id: 2, name: 'Item 2', category: 'Category 2', price: 20.0, inStock: false),
    ];
    return items.where((item) => item.category == division).toList();
  }
}
