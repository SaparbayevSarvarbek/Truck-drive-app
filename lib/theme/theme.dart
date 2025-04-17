import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Asosiy rang (masalan: FAB, Switch)
  scaffoldBackgroundColor: Colors.white,
  // Scaffold uchun fon rangi
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue, // AppBar orqa fon rangi
    foregroundColor: Colors.white, // AppBar matn va ikonka rangi
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black), // Umumiy matn rangi
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true, // Input qutilari uchun orqa fon to‘ldirilgan
    fillColor: Colors.grey[200], // Input qutisi orqa fon rangi
    border: OutlineInputBorder(
      // Chegara rangi asosiy rang bilan bir xil
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
          color: Colors.blue,
          width: 2), // Asosiy rangga moslashtirilgan chegara
    ),
    contentPadding: EdgeInsets.symmetric(
        vertical: 20, horizontal: 10), // Inputni ichidagi padding
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // ElevatedButton fon rangi
      foregroundColor: Colors.white, // ElevatedButton matn rangi
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // Dropdown uchun orqa fon to‘ldirilgan
      fillColor: Colors.grey[200], // Dropdown qutisi orqa fon rangi
      border: OutlineInputBorder(
        // Chegara rangi asosiy rangga mos
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: Colors.blue,
            width: 2), // Asosiy rangga moslashtirilgan chegara
      ),
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.blue[50], // Drawer orqa fon rangi
    scrimColor:
        Colors.black.withOpacity(0.5), // Drawer ochilganda fonni qoraytirish
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blue, // Cursor rangi asosiy rangga moslashtirilgan
  ),
  // Card uchun chegara rangini asosiy rang bilan moslashtirish
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.blue, width: 2), // Card chegara rangi
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // Dark mod uchun tema
  scaffoldBackgroundColor: Colors.black,
  // Scaffold fon rangi
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900], // AppBar orqa fon rangi
    foregroundColor: Colors.white, // AppBar matn va ikonka rangi
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // Umumiy matn rangi
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true, // Input qutilari uchun orqa fon to‘ldirilgan
    fillColor: Colors.grey[800], // Input qutisi orqa fon rangi
    border: OutlineInputBorder(
      // Chegara rangi asosiy rangga moslashtirilgan
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
          color: Colors.teal, width: 2), // Dark tema uchun asosiy rang
    ),
    contentPadding: EdgeInsets.symmetric(
        vertical: 20, horizontal: 10), // Inputni ichidagi padding
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal, // ElevatedButton fon rangi
      foregroundColor: Colors.white, // ElevatedButton matn rangi
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // Dropdown uchun orqa fon to‘ldirilgan
      fillColor: Colors.grey[800], // Dropdown qutisi orqa fon rangi
      border: OutlineInputBorder(
        // Chegara rangi asosiy rangga mos
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: Colors.teal, width: 2), // Dark tema uchun asosiy rang
      ),
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[850], // Drawer orqa fon rangi
    scrimColor:
        Colors.black.withOpacity(0.7), // Drawer ochilganda fonni qoraytirish
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.teal, // Cursor rangi
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.teal, width: 2), // Card chegara rangi
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
