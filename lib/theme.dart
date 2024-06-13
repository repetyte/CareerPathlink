import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFFB0BEC5); // Gray
  static const Color tertiaryColor = Color(0xFFD32F2F); // Red

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: secondaryColor, // Gray accent color
    ),
    textTheme: const TextTheme(
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
      buttonColor: tertiaryColor, // Red button background color
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryColor,
        backgroundColor: tertiaryColor, // Red button text color
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  );
}
