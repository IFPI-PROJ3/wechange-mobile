import 'package:flutter/material.dart';

ThemeData default_theme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(const Color(0xFF116B67)),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF116B67)),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF116B67),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF116B67)),
  useMaterial3: true,
);
