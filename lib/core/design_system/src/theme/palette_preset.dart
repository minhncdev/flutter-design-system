// core/design_system/src/theme/palette_preset.dart
//
// PalettePreset describes a selectable palette "preset" for DS theme building.
// - Token-driven: references PrimitivePalettes + BrandColorSelection.
// - DS does NOT manage selection state.

library;

import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Brightness;

import '../foundations/app_colors.dart';
import '../foundations/semantic_mapping_profile.dart';
import '../tokens/color_palette.dart';
import 'preset_preview.dart';

@immutable
class PalettePreset {
  /// Unique ID used by apps (and Slot mapping).
  final String id;

  /// Human-readable name for UI/debug.
  final String displayName;

  /// Primitive palettes (neutral + chromatic scales).
  final PrimitivePalettes palettes;

  /// Brand/accent selection (primary/secondary/etc).
  final BrandColorSelection brand;

  /// Preset chỉ có 1 tone duy nhất (light OR dark).
  /// Dùng để:
  /// - preset mode: ép ThemeMode theo tone này, không phụ thuộc system brightness.
  final Brightness toneBrightness;

  /// Semantic mapping profile (how brand shades map into semantic roles).
  final AppSemanticMappingProfile mappingProfile;

  /// Preview is derived from tokens (palettes + brand + toneBrightness).
  /// This prevents mismatch between "preview" and actual theme mapping.
  PresetPreview get preview {
    final colors = toneBrightness == Brightness.light
        ? AppColors.light(
            palettes: palettes,
            brand: brand,
            mappingProfile: mappingProfile,
          )
        : AppColors.dark(
            palettes: palettes,
            brand: brand,
            mappingProfile: mappingProfile,
          );

    return PresetPreview(
      background: colors.background,
      primary: colors.primary,
      accents: <Color>[colors.secondary, colors.accent, colors.success],
    );
  }

  /// Optional documentation.
  final String? description;

  const PalettePreset({
    required this.id,
    required this.displayName,
    required this.palettes,
    required this.brand,
    required this.toneBrightness,
    this.mappingProfile = AppSemanticMappingProfiles.material3,
    this.description,
  });
}
