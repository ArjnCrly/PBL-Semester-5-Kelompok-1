import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Warna diambil dari file desain (Figma export).
class DcColors {
  DcColors._();

  static const primary = Color(0xFFA53149); // tombol & menu aktif
  static const primaryDark = Color(0xFF8A1F36);
  static const background = Color(0xFFF9F9FF);
  static const surface = Color(0xFFFFFFFF);
  static const container = Color(0xFFF0F3FF); // kartu statistik, chip, panel
  static const blueContainer = Color(0xFFD8E3FB);
  static const greenContainer = Color(0xFFAEEECB);
  static const onGreen = Color(0xFF0E5138);
  static const pinkContainer = Color(0xFFF7CBCF);
  static const textPrimary = Color(0xFF141B2C);
  static const textSecondary = Color(0xFF574143);
  static const textMuted = Color(0xFF7B6E70);
  static const shadow = Color(0x14141B2C);
}

/// Pintasan gaya teks (Plus Jakarta Sans).
TextStyle dc(
  double size, {
  FontWeight weight = FontWeight.w500,
  Color color = DcColors.textPrimary,
  double? height,
  double? letterSpacing,
}) {
  return GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DcColors.primary,
        primary: DcColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: DcColors.background,
    );
    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
        bodyColor: DcColors.textPrimary,
        displayColor: DcColors.textPrimary,
      ),
    );
  }
}
