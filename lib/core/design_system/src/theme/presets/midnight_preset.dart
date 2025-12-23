// lib/core/design_system/src/theme/presets/fintech_midnight_preset.dart
//
// Fintech midnight palette preset extracted from HTML mocks.
// - Uses PrimitivePalettes.fintechMidnight (navy neutrals + emerald brand)

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../design_system.dart';

@immutable
final class FintechMidnightPreset {
  const FintechMidnightPreset._();

  static const PalettePreset preset = PalettePreset(
    id: 'fintech_midnight',
    displayName: 'Fintech Midnight',
    palettes: PrimitivePalettes.fintechMidnight,
    brand: BrandColorSelection.fintechEmerald,
    // Preset chỉ có 1 tone duy nhất (contract của PalettePreset)
    toneBrightness: Brightness.dark,
    mappingProfile: AppSemanticMappingProfiles.fintechMidnight,
    description: 'Navy/dark background variant from HTML mocks.',
  );
}
