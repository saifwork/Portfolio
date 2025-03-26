import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightPinkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFD9279B), // Main color
  scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Light background
  dividerColor: const Color(0xFFE0E0E0),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, // ✅ This is correct
    foregroundColor: Colors.black, // ✅ Change this to black for proper contrast
    elevation: 4,
  ),
  cardTheme: const CardTheme(
    color: Colors.white, // White card background
    shadowColor: Colors.black12,
    elevation: 2,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFD9279B),
    secondary: Color(0xFF6200EA), // A contrasting secondary color
    surface: Colors.white, // Surface color
  ),
  cardColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFD9279B),
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFD9279B),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 57, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 45, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: 36, fontWeight: FontWeight.w500),
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      bodySmall: TextStyle(color: Colors.black87, fontSize: 14),
      labelLarge: TextStyle(
          color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w400),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black54),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black),
    ),
    hintStyle: const TextStyle(color: Colors.black54),
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
);
