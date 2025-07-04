import 'package:flutter/material.dart';

class AppTheme {
  static const Color whiteColor = Color(0xFFFFFFFF); // White
  static const Color greyColor = Color(0x80808080); // Gray
  static const Color redColor = Color(0xFFFF0000); // Red
  static const Color blackColor = Color(0xFF000000); // Black

  static final OutlineInputBorder roundedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40.0), // Rounded corners
    borderSide: BorderSide(
      color: greyColor, // Gray line color
    ),
  );

  static final ThemeData themeData = ThemeData(
    primarySwatch: MaterialColor(0xFF808080, <int, Color>{
      50: Color(0xFFE0E0E0),
      100: Color(0xFFB3B3B3),
      200: Color(0xFF808080),
      300: Color(0xFF4D4D4D),
      400: Color(0xFF262626),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    }), // Gray primary color
    fontFamily: 'Montserrat',
    primaryColor: whiteColor,
    hintColor: greyColor,
    scaffoldBackgroundColor: whiteColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      // Primary colors
      primary: greyColor,
      secondary: whiteColor,
      tertiary: redColor,
      surface: whiteColor,
      error: redColor,

      // On colors
      onPrimary: blackColor,
      onSecondary: blackColor,
      onTertiary: whiteColor,
      onSurface: blackColor,
      onError: whiteColor,
    ),
    useMaterial3: true,
    textTheme: TextTheme(
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
      surfaceTintColor: whiteColor,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: blackColor),
      actionsIconTheme: IconThemeData(color: whiteColor),
    ),
    buttonTheme: ButtonThemeData(
      // Button theme
      buttonColor: redColor, // Red button background color
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      // Elevated Button Theme
      style: ElevatedButton.styleFrom(
        iconColor: whiteColor,
        foregroundColor: whiteColor,
        backgroundColor: redColor, // Red button text color
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
        iconColor: redColor,
        foregroundColor: redColor, // Red button text color
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
      backgroundColor: redColor, // Red FAB background
      foregroundColor: whiteColor, // White icon/text color
      elevation: 6, // Shadow elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // Modern rounded corners
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: whiteColor,
      border: roundedInputBorder,
      enabledBorder: roundedInputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: greyColor, // Grey line when focused
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: redColor, // Red line for errors
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(
          color: redColor, // Red line for focused errors
          width: 2.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      hintStyle: TextStyle(color: greyColor), // Gray hint text
      labelStyle: TextStyle(color: blackColor), // Black label text
    ),
    snackBarTheme: SnackBarThemeData(
      width: 500,
      backgroundColor: whiteColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),// Floating behavior for SnackBar
      insetPadding: EdgeInsets.all(16.0), // Padding of 16 on all sides
    ),
  );
}