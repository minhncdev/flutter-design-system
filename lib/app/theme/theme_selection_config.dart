// app/theme/theme_selection_config.dart
//
// Type-safe theme selection config for app shell.
// - SystemBased: ThemeMode + BrandId (palette defaults lấy từ ThemeDefaults).
// - PresetBased: presetId + toneBrightness (preset chỉ có 1 tone duy nhất).

library;

import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';
import '../config/brand_defaults.dart';

sealed class ThemeSelectionConfig {
  const ThemeSelectionConfig();

  ThemeSelectionType get type;

  Map<String, Object?> toJson();

  static ThemeSelectionConfig fromJson(Map<String, Object?> json) {
    final type = json['type'];
    if (type == 'systemBased') {
      return SystemBasedThemeConfig.fromJson(json);
    }
    if (type == 'brandBased') {
      return PresetBasedThemeConfig.fromJson(json);
    }
    // Fallback safe default
    return const SystemBasedThemeConfig();
  }
}

final class SystemBasedThemeConfig extends ThemeSelectionConfig {
  final ThemeMode mode;

  /// Brand is ONLY configurable in SystemBased mode.
  final String brandId;

  const SystemBasedThemeConfig({
    this.mode = ThemeMode.system,
    this.brandId = BrandDefaults.defaultBrandId,
  });

  @override
  ThemeSelectionType get type => ThemeSelectionType.systemBased;

  SystemBasedThemeConfig copyWith({ThemeMode? mode, String? brandId}) {
    return SystemBasedThemeConfig(
      mode: mode ?? this.mode,
      brandId: brandId ?? this.brandId,
    );
  }

  @override
  Map<String, Object?> toJson() => <String, Object?>{
    'type': 'systemBased',
    'mode': mode.name,
    'brandId': brandId,
  };

  static SystemBasedThemeConfig fromJson(Map<String, Object?> json) {
    ThemeMode readMode(String? v) => ThemeMode.values
        .where((e) => e.name == v)
        .cast<ThemeMode?>()
        .firstWhere((e) => e != null, orElse: () => ThemeMode.system)!;

    return SystemBasedThemeConfig(
      mode: readMode(json['mode'] as String?),
      brandId: (json['brandId'] as String?) ?? BrandDefaults.defaultBrandId,
    );
  }
}

final class PresetBasedThemeConfig extends ThemeSelectionConfig {
  /// Selected palette presetId.
  final String presetId;

  /// (1.1) Lưu preset này thuộc tone light hay dark.
  /// Preset mode sẽ ép ThemeMode theo giá trị này (không phụ thuộc system).
  final Brightness toneBrightness;

  const PresetBasedThemeConfig({
    required this.presetId,
    required this.toneBrightness,
  });

  @override
  ThemeSelectionType get type => ThemeSelectionType.brandBased;

  PresetBasedThemeConfig copyWith({
    String? presetId,
    Brightness? toneBrightness,
  }) {
    return PresetBasedThemeConfig(
      presetId: presetId ?? this.presetId,
      toneBrightness: toneBrightness ?? this.toneBrightness,
    );
  }

  @override
  Map<String, Object?> toJson() => <String, Object?>{
    'type': 'brandBased',
    'presetId': presetId,
    'toneBrightness': toneBrightness.name, // "light" | "dark"
  };

  static PresetBasedThemeConfig fromJson(Map<String, Object?> json) {
    // Backward compatible:
    // - old key: brandPresetId
    // - new key: presetId
    final id =
        (json['presetId'] as String?) ??
        (json['brandPresetId'] as String?) ??
        'white';

    final toneStr = json['toneBrightness'] as String?;
    final tone = toneStr == 'dark' ? Brightness.dark : Brightness.light;

    return PresetBasedThemeConfig(presetId: id, toneBrightness: tone);
  }
}
