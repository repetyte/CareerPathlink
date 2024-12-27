import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFFFFF); // White
  static const Color secondaryColor = Color(0x80808080); // Gray
  static const Color tertiaryColor = Color(0xFFFF0000); // Red
  static const Color quaternaryColor = Color(0xFF000000); // Black

  static final OutlineInputBorder roundedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40.0), // Rounded corners
    borderSide: BorderSide(
      color: secondaryColor, // Gray line color
    ),
  );

  static final ThemeData themeData = ThemeData(
    primarySwatch: Colors.grey, // Gray primary color
    fontFamily: GoogleFonts.montserrat().fontFamily, // Font family
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: secondaryColor, // Gray accent color
    ),
    // colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
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
      iconTheme: IconThemeData(color: quaternaryColor),
      actionsIconTheme: IconThemeData(color: primaryColor),
    ),
    buttonTheme: ButtonThemeData(
      // Button theme
      buttonColor: tertiaryColor, // Red button background color
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      // Elevated Button Theme
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryColor,
        backgroundColor: tertiaryColor, // Red button text color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        // minimumSize: const Size(200, 50),
        elevation: 6, // Shadow elevation
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          
        ),
      ),
      
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: tertiaryColor, // Red button text color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        // minimumSize: const Size(200, 50),
        elevation: 6, // Shadow elevation
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: tertiaryColor, // Red FAB background
      foregroundColor: primaryColor, // White icon/text color
      elevation: 6, // Shadow elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // Modern rounded corners
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: roundedInputBorder,
      enabledBorder: roundedInputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: quaternaryColor, // Red line when focused
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: tertiaryColor, // Red line for errors
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: tertiaryColor, // Red line for focused errors
          width: 2.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      hintStyle: TextStyle(color: secondaryColor), // Gray hint text
      labelStyle: TextStyle(color: quaternaryColor), // Black label text
    ),
    
  );
}