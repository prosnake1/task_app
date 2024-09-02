import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: 'VKSansDisplay',
  scaffoldBackgroundColor: const Color.fromRGBO(235, 237, 240, 1),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Color.fromRGBO(38, 136, 235, 1),
    ),
    backgroundColor: Color.fromRGBO(235, 237, 240, 1),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: "VKSansDisplay",
      color: Colors.black,
      fontSize: 22,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
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
      borderSide: const BorderSide(color: Color.fromRGBO(38, 136, 235, 1)),
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
