import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF5865F2);
  static const Color secondary = Color(0xFF9D50BB);
  static const Color tertiary = Color(0xFFFFCF00);
  static const Color neutral = Color(0xFF7B719D);

  // Background
  static const Color background = Color(0xFFF7F5FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF0EDFF);
  static const Color glassSurface = Color(0x33FFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF201A35);
  static const Color textSecondary = Color(0xFF6F668A);
  static const Color textMuted = Color(0xFF9B94B5);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Borders / Divider
  static const Color border = Color(0xFFE5E0F5);
  static const Color divider = Color(0xFFEDE8FA);

  // Shadows
  static const Color shadow = Color(0x1A201A35);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bluePurpleGradient = LinearGradient(
    colors: [
      Color(0xFF5865F2),
      Color(0xFF7A5AF8),
      Color(0xFF9D50BB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleDarkGradient = LinearGradient(
    colors: [
      Color(0xFF201A35),
      Color(0xFF4F46E5),
      Color(0xFF9D50BB),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [
      Color(0xFFFFCF00),
      Color(0xFFFFA800),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient softGlassGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.45),
      Colors.white.withOpacity(0.16),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxShadow softShadow = BoxShadow(
    color: shadow,
    blurRadius: 24,
    offset: const Offset(0, 12),
  );

  static BoxShadow cardShadow = BoxShadow(
    color: primary.withOpacity(0.12),
    blurRadius: 20,
    offset: const Offset(0, 10),
  );
}