import 'package:flutter/material.dart';
import 'app_fonts.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Viga',
  primaryColor: const Color(0xFF5e33e0),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF5e33e0),
    primary: const Color(0xFF5e33e0),
    secondary: const Color(0xFF2d2c2f),
    surface: const Color(0xFF1d1d1e),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF5e33e0),
    selectionColor: Color(0xFF5e33e0),
    selectionHandleColor: Color(0xFF5e33e0),
  ),
  textTheme: TextTheme(
    headlineLarge: AppFonts.heading,
    titleLarge: AppFonts.headingBlack,
    bodyMedium: AppFonts.body,
    labelSmall: AppFonts.label,
    headlineMedium: AppFonts.headingMedium,
    titleSmall: AppFonts.titleSmall,
    bodySmall: AppFonts.bodySmall,
    titleMedium: AppFonts.titleMedium,
    bodyLarge: AppFonts.bodyLarge,
    displayLarge: AppFonts.displayLarge,
    displayMedium: AppFonts.display,
    displaySmall: AppFonts.displaySmall,
  ),
  primaryIconTheme: IconThemeData(color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF5e33e0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF5e33e0), width: 2.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5e33e0),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: const Color.fromARGB(255, 255, 255, 255),
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  useMaterial3: true,
);
