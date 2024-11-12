import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFFFFF); // White
  static const Color secondaryColor = Color(0x80808080); // Gray
  static const Color tertiaryColor = Color(0xFFFF0000); // Red

  static final ThemeData themeData = ThemeData(
    primarySwatch: Colors.grey, // Gray primary color
    fontFamily: GoogleFonts.montserrat().fontFamily, // Font family
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   secondary: secondaryColor, // Gray accent color
    // ),
    colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
    useMaterial3: true,
    textTheme: const TextTheme(
      // Text theme
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: Colors.black,
      ),
    ),
    appBarTheme: const AppBarTheme(
      // Appbar  theme
      color: primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: primaryColor),
    ),
    buttonTheme: ButtonThemeData(
      // Button theme
      buttonColor: tertiaryColor, // Red button background color
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      // Elevated Button Theme
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryColor,
        backgroundColor: tertiaryColor, // Red button text color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        // minimumSize: const Size(200, 50),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    ),
  );
}