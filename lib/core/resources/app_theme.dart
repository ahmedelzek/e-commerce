import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme{
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.red,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      centerTitle: true,
    ),
    useMaterial3: true,
    fontFamily: 'Montserrat',
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.lightGrey,
      prefixIconColor: AppColors.grey,
      suffixIconColor: AppColors.grey,
      hintStyle: TextStyle(
        color: AppColors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w200,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: AppColors.lightGrey,
              width: 1
          )
      ),
    ),
  );
}