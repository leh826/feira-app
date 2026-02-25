import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightGrey,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryGreen,
      secondary: AppColors.lightBeige,
      surface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}