// app/config/brand_defaults.dart
//
// App-owned brand options (chỉ dùng khi SystemBased).
// Preset mode: brand bị "baked-in" theo preset, UI không cho override.

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color;

import '../../core/design_system/design_system.dart';

@immutable
final class BrandOption {
  final String id;
  final String displayName;
  final BrandColorSelection selection;
  final Color previewColor;

  const BrandOption({
    required this.id,
    required this.displayName,
    required this.selection,
    required this.previewColor,
  });
}

class BrandDefaults {
  const BrandDefaults._();

  /// Dùng prefix để tránh đụng id với PalettePreset (ví dụ preset "green").
  static const String defaultBrandId = 'brand_base';

  static final List<BrandOption> options = <BrandOption>[
    BrandOption(
      id: 'brand_base',
      displayName: 'Base',
      selection: BrandColorSelection.base,
      previewColor: BrandColorSelection.base.primary[600],
    ),
    BrandOption(
      id: 'brand_green',
      displayName: 'Green',
      selection: BrandColorSelection.green,
      previewColor: BrandColorSelection.green.primary[600],
    ),
    BrandOption(
      id: 'brand_fintech',
      displayName: 'Fintech',
      selection: BrandColorSelection.fintechGreen,
      previewColor: BrandColorSelection.fintechGreen.primary[600],
    ),
  ];

  static BrandOption byId(String id) {
    return options.firstWhere(
      (e) => e.id == id,
      orElse: () => options.firstWhere((e) => e.id == defaultBrandId),
    );
  }

  static BrandColorSelection resolve(String id) => byId(id).selection;
}
