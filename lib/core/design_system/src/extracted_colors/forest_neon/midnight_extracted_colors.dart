/// Raw color literals extracted from the expense-app HTML prototypes (Midnight variant).
/// - Source-of-truth list for future refactors.
/// - Palette scales may choose a subset of these values.
library;

import 'package:flutter/material.dart';

final class FintechMidnightExtractedColors {
  const FintechMidnightExtractedColors._();

  // Base
  static const Color white = Color(0xFFFFFFFF);

  // Background / surfaces
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundMain = Color(0xFF0D1A2E); // dark background
  static const Color cardMain = Color(0xFF1A2C42); // dark surface/card

  // Lines
  static const Color borderSubtle = Color(0xFF3C5A7F);

  // Text
  static const Color textMuted = Color(0xFF8FA3BC);

  // Brand
  static const Color primary = Color(0xFF00E676);
  static const Color primaryDark = Color(0xFF00C853);

  // Status
  static const Color danger = Color(0xFFFF5252);
}
