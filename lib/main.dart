import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/helpers/database_helper.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/views/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseHelper>(
          create: (_) => DatabaseHelper(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(client: http.Client()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashView(),
      ),
    );
  }
}
