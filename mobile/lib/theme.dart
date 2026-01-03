import 'package:flutter/material.dart';

const primaryColor = Color(0xFF14B8A6); // Teal

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.grey[100],
  fontFamily: 'Roboto',
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFF1F2937),
);
