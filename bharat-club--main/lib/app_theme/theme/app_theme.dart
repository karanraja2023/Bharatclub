import 'package:flutter/material.dart';

class AppColors {
  // --- Base Colors ---
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Colors.black;
  static const Color background = Color(0xFFF8FAFC);
  static const Color error = Color.fromARGB(255, 230, 0, 38);
  static const Color textPrimary = Color(0xFF334155);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color shadow = Color(0xFF6B7280);

  // --- Brand Colors ---
  static const Color primaryGreen = Color(0xFF39AB3F); // Primary green shade
  static const Color secondaryGreen = Color(0xFF69A979); // Lighter green shade
  static const Color tertiaryGreen = Color(0xFF81C784); // Softer green shade
  static const Color indiaOrange = Color(0xFFED9F54);

  // --- MaterialColor Variants ---
  static const int _primaryGreenValue = 0xFF69A979;
  static const MaterialColor cAppColors =
      MaterialColor(_primaryGreenValue, <int, Color>{
        50: Color(0xFFD7FDE1),
        100: Color(0xFFC0F1CD),
        200: Color(0xFFABE3BA),
        300: Color(0xFF91CCA0),
        400: Color(0xFF7CBB8C),
        500: Color(_primaryGreenValue),
        600: Color(0xFF61A271),
        700: Color(0xFF579B68),
        800: Color(0xFF4D915E),
        900: Color(0xFF468C58),
      });

  static const int _redValue = 0xFFC23F38;
  static const MaterialColor cAppColorsRed =
      MaterialColor(_redValue, <int, Color>{
        50: Color(0xFFFF958E),
        100: Color(0xFFFD7B73),
        200: Color(0xFFF1675F),
        300: Color(0xFFE15851),
        400: Color(0xFFD24B44),
        500: Color(_redValue),
        600: Color(0xFFB63730),
        700: Color(0xFFAB2F29),
        800: Color(0xFFA12721),
        900: Color(0xFF96211B),
      });

  static const int _yellowValue = 0xFFFFCD00;
  static const MaterialColor cAppColorsYellow =
      MaterialColor(_yellowValue, <int, Color>{
        50: Color(0xFFFFDB85),
        100: Color(0xFFFFD963),
        200: Color(0xD7FFD43E),
        300: Color(0xFFFFD428),
        400: Color(0xFFFFD21A),
        500: Color(_yellowValue),
        600: Color(0xFFE0B300),
        700: Color(0xFFBD9700),
        800: Color(0xFF9D8000),
        900: Color(0xFF806400),
      });

  // --- Legacy aliases (for backward compatibility with existing code) ---
  static const Color cAppColorsBlue = secondaryGreen;
  static const Color cAppColorsGreen = primaryGreen;
  static const Color cardBackground = white;
  static const Color cardHeaderStart = Color(0xFFEDE9FE);
  static const Color cardHeaderEnd = Color(0xFFF5F3FF);
  static const Color primaryColor = black;
  static const Color accentColor = Colors.amber;
  static const Color dividerColor = Colors.black12;
  static const Color scaffoldBackgroundColor = white;
  static const Color backgroundColor = background;
}
