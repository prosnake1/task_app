import 'package:flutter/material.dart';
import 'package:task_app/app/theme/colors.dart';

final lightTheme = ThemeData(
  fontFamily: 'VKSansDisplay',
  scaffoldBackgroundColor: ThemeColors.background,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: ThemeColors.primary,
    ),
    backgroundColor: ThemeColors.background,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: "VKSansDisplay",
      color: Colors.black,
      fontSize: 22,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColors.primary,
      disabledBackgroundColor: ThemeColors.primary.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      fontFamily: 'VKSansDisplay',
    ),
    fillColor: const Color.fromRGBO(242, 243, 245, 1),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ThemeColors.primary),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.only(left: 15),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        fontSize: 20, fontFamily: 'VKSansDisplay', fontWeight: FontWeight.w600),
    labelMedium: TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(129, 140, 153, 1),
      fontFamily: 'VKSansDisplay',
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'VKSansDisplay',
    ),
  ),
);
