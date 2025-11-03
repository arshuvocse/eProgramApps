
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../config/app_config.dart';
import '../config/api_endpoints.dart';

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

    final uri = Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.login}').replace(queryParameters: queryParams);

    return await http.post(uri);
  }
}
