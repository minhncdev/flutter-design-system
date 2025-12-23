// lib/core/design_system/src/theme/presets/fintech_preset.dart
//
// Fintech palette preset extracted from HTML mocks.
// - Uses PrimitivePalettes.fintech (green-tinted neutrals + neon green brand)

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../design_system.dart';

@immutable
final class FintechPreset {
  const FintechPreset._();

  static const PalettePreset preset = PalettePreset(
    id: 'fintech',
    displayName: 'Fintech',
    palettes: PrimitivePalettes.fintech,
    brand: BrandColorSelection.fintechGreen,
    toneBrightness: Brightness.dark,
    mappingProfile: AppSemanticMappingProfiles.fintech,
    description: 'From HTML mocks (overview/history/plan/debt).',
  );
}
