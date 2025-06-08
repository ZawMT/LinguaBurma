import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeBluish = ThemeData(
    primaryColor: Colors.blue,
    primaryColorLight: Colors.lightBlue,
    primarySwatch: Colors.lightBlue, // Provides color shades
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: GoogleFonts.interTight(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.interTight(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleSmall: GoogleFonts.interTight(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyMedium: const TextStyle(
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.interTight(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue).copyWith(
      secondary: Colors.blueAccent, // Example for correct in greenish theme
      error: Colors.deepOrangeAccent, // Example for wrong in greenish theme
      brightness: Brightness.light
    ),
    shadowColor: Colors.purple
    // Define other theme properties as needed (e.g., colorScheme, cardTheme, etc.)
  );

  static ThemeData themeGreenish = ThemeData(
    primaryColor: Colors.green,
    primaryColorLight: Colors.lightGreen,
    primarySwatch: Colors.lightGreen,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: GoogleFonts.interTight(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.interTight(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.interTight(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      bodyMedium: const TextStyle(
        color: Colors.white70,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.interTight(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen).copyWith(
      secondary: Colors.greenAccent, // Example for correct in greenish theme
      error: Colors.deepOrangeAccent, // Example for wrong in greenish theme
      brightness: Brightness.dark
    ),
    shadowColor: Colors.amber
  );
}