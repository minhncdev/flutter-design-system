// lib/core/design_system/src/theme/presets/fintech_light_preset.dart
//
// Fintech preset (light background variant).
// - Uses PrimitivePalettes.fintechLight (light bg neutral + neon green brand)

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../design_system.dart';

@immutable
final class FintechLightPreset {
  const FintechLightPreset._();

  static const PalettePreset preset = PalettePreset(
    id: 'fintech_light',
    displayName: 'Fintech Light',
    palettes: PrimitivePalettes.fintechLight,
    brand: BrandColorSelection.fintechGreen,
    toneBrightness: Brightness.light,
    mappingProfile: AppSemanticMappingProfiles.fintechLight,
    description: 'Light background variant from HTML mocks.',
  );
}
