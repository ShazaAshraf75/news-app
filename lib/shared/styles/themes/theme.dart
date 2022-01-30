import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData newsLightTheme = ThemeData(
    textTheme: TextTheme(
      bodyText1: GoogleFonts.exo(
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0)),
    ),
    primarySwatch: Colors.red,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.red[600]),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 15,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red[600]),
        titleTextStyle: GoogleFonts.exo(
          textStyle: TextStyle(
            color: Colors.red[600],
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 25,
          ),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedLabelStyle: GoogleFonts.exo(),
      unselectedLabelStyle: GoogleFonts.exo(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red[600],
    ));

ThemeData newsDarkTheme = ThemeData(
    textTheme: TextTheme(
      bodyText1: GoogleFonts.exo(
          textStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0)),
    ),
    primarySwatch: Colors.red,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.red[600]),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
        titleSpacing: 15,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red[600]),
        titleTextStyle: GoogleFonts.exo(
          textStyle: TextStyle(
            color: Colors.red[600],
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 25,
          ),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedLabelStyle: GoogleFonts.exo(),
        unselectedLabelStyle: GoogleFonts.exo(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red[600],
        unselectedItemColor: Colors.grey[300]));
