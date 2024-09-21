import 'package:flutter/material.dart';

final ThemeData sylloutTheme = ThemeData(
  primaryColor: const Color.fromRGBO(0, 0, 0, 1),
  hintColor: Colors.orange,
  scaffoldBackgroundColor: Colors.black, // Ensure the scaffold background is black
  textTheme: TextTheme(
    headlineSmall: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black, // Set the background color of the BottomNavigationBar to black
    selectedItemColor: Colors.orange, // Color for the selected item
    unselectedItemColor: Colors.white, // Color for the unselected items
    type: BottomNavigationBarType.fixed, // Ensures the background color covers the entire bar
  ),
);
