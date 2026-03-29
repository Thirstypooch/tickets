import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography styles matching the Tailwind text classes used in the Next.js app.
class AppTypography {
  AppTypography._();

  static TextTheme get textTheme => GoogleFonts.interTextTheme();

  // Hero / Display
  static TextStyle get display => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 1.1,
  );

  // Page title (text-3xl bold)
  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  // Section heading (text-2xl bold)
  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  // Sub-heading (text-xl semibold)
  static TextStyle get h3 => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Card title (text-lg semibold)
  static TextStyle get h4 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body large (text-base)
  static TextStyle get bodyLg => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Body (text-sm)
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Small (text-xs)
  static TextStyle get small => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Label (text-xs font-medium uppercase)
  static TextStyle get label => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.5,
  );

  // Price display (text-2xl bold)
  static TextStyle get price => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
}
