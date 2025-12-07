import 'package:flutter/material.dart';

class AppColors {
  // --- Raw Palette ---
  // Green
  static const Color greenSuccess = Color(0xFF12B76A);

  // Red
  static const Color redDelete = Color(0xFFFF0000);

  // Blue
  static const Color blue50 = Color(0xFFEDFAFF);
  static const Color primaryBlue = Color(0xFF0075FF); // Primary_blue

  // Gray
  static const Color gray50 = Color(0xFFF6F6F6);
  static const Color gray100 = Color(0xFFE7E7E7);
  static const Color gray200 = Color(0xFFD1D1D1);
  static const Color gray300 = Color(0xFFB0B0B0);
  static const Color gray400 = Color(0xFF888888);
  static const Color gray500 = Color(0xFF6D6D6D);
  static const Color gray900 = Color(0xFF3D3D3D);
  static const Color gray950 = Color(0xFF202020);

  // --- Semantic Aliases (Usage based) ---

  static const Color primary = primaryBlue;
  static const Color scaffoldBackground = gray50;
  static const Color cardBackground = Colors.white;

  static const Color divider = Color(0xFFF4F4F4); // Lighter than gray100

  static const Color textPrimary = gray950; // Main text
  static const Color textSecondary = gray400; // Subtitles

  // Section Headers
  static const Color sectionHeader = gray400; // "A", "B" text

  // Inputs
  static const Color inputBackground = gray50;
  static const Color inputBorder = gray200;

  // Icons & Placeholders
  static const Color avatarPlaceholder = gray200;
  static const Color iconColor = gray400;
}
