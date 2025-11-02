
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/item_viewmodel.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => ItemViewModel()),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          final appRouter = AppRouter(authViewModel: authViewModel);
          return MaterialApp.router(
            title: 'e-Program',
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF1E232C),
              scaffoldBackgroundColor: const Color(0xFF1E232C),
              textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withAlpha((255 * 0.5).round())),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
