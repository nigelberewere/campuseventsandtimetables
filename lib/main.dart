import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Events & Timetables',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blueMirage,
          primary: AppColors.blueMirage,
          secondary: AppColors.amberSmoke,
          background: AppColors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blueMirage,
          foregroundColor: AppColors.white,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
