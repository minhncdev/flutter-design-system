/// Raw color literals extracted from the expense-app HTML prototypes.
/// - Source-of-truth list for future refactors.
/// - Palette scales may choose a subset of these values.
library;

import 'package:flutter/material.dart';

final class FintechExtractedColors {
  const FintechExtractedColors._();

  // Base
  static const Color white = Color(0xFFFFFFFF);

  // Background / surfaces
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);

  static const Color surfaceMain = Color(0xFF1A3325);
  static const Color surfaceAlt = Color(0xFF1C2E24);
  static const Color surface = Color(0xFF233A2E);
  static const Color surfaceHover = Color(0xFF23352B);
  static const Color surfaceOverlay = Color(0xFF20402B);

  // Borders
  static const Color border = Color(0xFF2A4234);
  static const Color borderAlt = Color(0xFF2A4535);
  static const Color borderStrong = Color(0xFF326744);

  // Text
  static const Color textMutedDark = Color(0xFF92C9A4);

  // Brand (primary)
  static const Color primary = Color(0xFF13EC5B);
  static const Color primaryHover = Color(0xFF11D452);
  static const Color primaryHoverAlt = Color(0xFF10D650);
  static const Color primaryPressed = Color(0xFF10C94D);
  static const Color primaryPressedAlt = Color(0xFF10C64C);
  static const Color primaryDark = Color(0xFF0EA641);

  // Danger
  static const Color danger = Color(0xFFFF5252);
  static const Color dangerLight = Color(0xFFFF5C5C);
  static const Color dangerAlt = Color(0xFFEF4444);
}
