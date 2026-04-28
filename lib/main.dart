import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const CampusEventsApp());
}

class CampusEventsApp extends StatelessWidget {
  const CampusEventsApp({super.key});

    @override
    Widget build(BuildContext context) {
      const amberSmoke = Color(0xFFF2E0D0);
      const blueMirage = Color(0xFF5E88B0);
      const fallbackBlueMirage = Color(0xFF5C6D7C);

      final colorScheme = ColorScheme.fromSeed(
        seedColor: blueMirage,
        brightness: Brightness.light,
      ).copyWith(
        primary: blueMirage,
        secondary: fallbackBlueMirage,
        tertiary: amberSmoke,
        surface: const Color(0xFFFFFBF6),
      );

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'campuseventsandtimetables',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: const Color(0xFFFFFBF6),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: fallbackBlueMirage,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF9F6F0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFE6D6C5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: blueMirage, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
        ),
        home: const LoginPage(),
      );
    }
  }
 
  // Backwards-compatible wrapper for tests expecting `MyApp`.
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) => const CampusEventsApp();
  }
