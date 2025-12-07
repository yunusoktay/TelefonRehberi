import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // --- Headings ---

  // Headline (Bold) - Assumed ~24px from image
  static final TextStyle headline = GoogleFonts.mulish(
    fontSize: 22,
    fontWeight: FontWeight.w800, // Increased to ExtraBold
    color: AppColors.textPrimary,
  );

  // Large Display (For Page Titles)
  static final TextStyle displayLarge = GoogleFonts.mulish(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Headline Small (Bold) - Assumed ~20px
  static final TextStyle headlineSmall = GoogleFonts.mulish(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // --- Titles ---

  // Title Large (Bold) - Section Headers like "A"
  static final TextStyle titleLarge = GoogleFonts.mulish(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.sectionHeader,
  );

  // Title Medium (Bold/SemiBold/Medium/Regular) - Contact Names
  static final TextStyle titleMediumBold = GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle titleMediumSemiBold = GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // --- Body ---

  // Body (Regular) - Phone numbers
  static final TextStyle bodyRegular = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle bodyMedium = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodySmall = GoogleFonts.mulish(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
