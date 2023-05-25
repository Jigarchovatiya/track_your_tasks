import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color(0x1A003E5A),
  100: const Color(0x33003E5A),
  200: const Color(0x4D003E5A),
  300: const Color(0x66003E5A),
  400: const Color(0x80003E5A),
  500: const Color(0x99003E5A),
  600: const Color(0xB3003E5A),
  700: const Color(0xCC003E5A),
  800: const Color(0xE6003E5A),
  900: const Color(0xFF003E5A),
};

class AppColors {
  static MaterialColor materialColor = MaterialColor(0xFF003E5A, color);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blue = Colors.blue;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color splashBg = Color(0xccd5d5d5);
  static const Color logoText = Color(0xFF003e5a);
}
