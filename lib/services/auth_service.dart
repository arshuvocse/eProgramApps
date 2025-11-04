import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/config/api_endpoints.dart';
import 'package:myapp/config/app_config.dart';
import 'package:myapp/models/user_model.dart';

class AuthService {
  final http.Client client;

  AuthService({required this.client});

  Future<User> login(String username, String password, String imei) async {
    final response = await client.post(
      Uri.parse(
          '${AppConfig.baseUrl}${ApiEndpoints.login}?UserName=$username&password=$password&Imei=$imei&DeviceToken=51193&Device=51193&AppVersion=51193&OS=51193&OS_Version=51193'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
