import 'package:flutter/material.dart';

/// Design tokens extracted from globals.css HSL values.
class AppColors {
  AppColors._();

  // Brand
  static const Color brand = Color(0xFF4F46E5); // indigo-600
  static const Color brandLight = Color(0xFF6366F1); // indigo-500
  static const Color brandDark = Color(0xFF4338CA); // indigo-700

  // Light theme tokens
  static const Color lightBackground = Colors.white;
  static const Color lightForeground = Color(0xFF0A0A0A); // hsl(0,0%,3.9%)
  static const Color lightCard = Colors.white;
  static const Color lightCardForeground = Color(0xFF0A0A0A);
  static const Color lightPrimary = Color(0xFF171717); // hsl(0,0%,9%)
  static const Color lightPrimaryForeground = Color(0xFFFAFAFA);
  static const Color lightSecondary = Color(0xFFF5F5F5); // hsl(0,0%,96.1%)
  static const Color lightSecondaryForeground = Color(0xFF171717);
  static const Color lightMuted = Color(0xFFF5F5F5);
  static const Color lightMutedForeground = Color(0xFF737373); // hsl(0,0%,45.1%)
  static const Color lightAccent = Color(0xFFF5F5F5);
  static const Color lightAccentForeground = Color(0xFF171717);
  static const Color lightDestructive = Color(0xFFEF4444); // hsl(0,84.2%,60.2%)
  static const Color lightDestructiveForeground = Color(0xFFFAFAFA);
  static const Color lightBorder = Color(0xFFE5E5E5); // hsl(0,0%,89.8%)
  static const Color lightInput = Color(0xFFE5E5E5);
  static const Color lightRing = Color(0xFF0A0A0A);

  // Dark theme tokens
  static const Color darkBackground = Color(0xFF0A0A0A); // hsl(0,0%,3.9%)
  static const Color darkForeground = Color(0xFFFAFAFA); // hsl(0,0%,98%)
  static const Color darkCard = Color(0xFF0A0A0A);
  static const Color darkCardForeground = Color(0xFFFAFAFA);
  static const Color darkPrimary = Color(0xFFFAFAFA);
  static const Color darkPrimaryForeground = Color(0xFF171717);
  static const Color darkSecondary = Color(0xFF262626); // hsl(0,0%,14.9%)
  static const Color darkSecondaryForeground = Color(0xFFFAFAFA);
  static const Color darkMuted = Color(0xFF262626);
  static const Color darkMutedForeground = Color(0xFFA3A3A3); // hsl(0,0%,63.9%)
  static const Color darkAccent = Color(0xFF262626);
  static const Color darkAccentForeground = Color(0xFFFAFAFA);
  static const Color darkDestructive = Color(0xFF7F1D1D); // hsl(0,62.8%,30.6%)
  static const Color darkDestructiveForeground = Color(0xFFFAFAFA);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkInput = Color(0xFF262626);
  static const Color darkRing = Color(0xFFD4D4D4); // hsl(0,0%,83.1%)

  // Semantic
  static const Color starYellow = Color(0xFFFACC15); // yellow-400
  static const Color heartRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF22C55E);
  static const Color warningOrange = Color(0xFFF97316);

  // Gray scale (Tailwind neutral)
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFE5E5E5);
  static const Color gray300 = Color(0xFFD4D4D4);
  static const Color gray400 = Color(0xFFA3A3A3);
  static const Color gray500 = Color(0xFF737373);
  static const Color gray600 = Color(0xFF525252);
  static const Color gray700 = Color(0xFF404040);
  static const Color gray800 = Color(0xFF262626);
  static const Color gray900 = Color(0xFF171717);
}
