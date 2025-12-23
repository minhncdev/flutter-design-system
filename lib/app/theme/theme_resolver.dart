// app/theme/theme_resolver.dart
//
// Resolve ThemeData from:
// - ThemeSelectionConfig (systemBased/brandBased)
// - Brightness -> PresetId mapping (ThemeDefaults)
// - Palette registry (ThemePaletteRegistry)
// - Cached ThemeData

library;

import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';
import '../config/brand_defaults.dart';
import '../config/theme_defaults.dart';
import 'theme_cache.dart';
import 'theme_selection_config.dart';

class ThemeResolver {
  final ThemePaletteRegistry _registry;
  final ThemeCache _cache;

  ThemeResolver({ThemePaletteRegistry? registry, ThemeCache? cache})
    : _registry = registry ?? ThemePaletteRegistry.instance,
      _cache = cache ?? ThemeCache();

  String resolvePresetId(ThemeSelectionConfig config, Brightness brightness) {
    return switch (config) {
      SystemBasedThemeConfig _ => ThemeDefaults.presetIdForBrightness(
        brightness,
      ),
      PresetBasedThemeConfig c => c.presetId,
    };
  }

  Brightness _effectiveBrightness(
    ThemeSelectionConfig config,
    Brightness requested,
  ) {
    return switch (config) {
      // Preset chỉ có 1 tone → ép brightness theo preset tone
      PresetBasedThemeConfig c => c.toneBrightness,
      _ => requested,
    };
  }

  String _brandKey(ThemeSelectionConfig config) {
    return switch (config) {
      SystemBasedThemeConfig c => c.brandId,
      // preset-based: brand "baked-in" theo preset
      PresetBasedThemeConfig _ => 'preset_brand',
    };
  }

  ThemeData buildTheme(ThemeSelectionConfig config, Brightness brightness) {
    final presetId = resolvePresetId(config, brightness);
    final effectiveBrightness = _effectiveBrightness(config, brightness);
    final brandKey = _brandKey(config);

    return _cache.getOrBuild(
      presetId: presetId,
      brightness: effectiveBrightness,
      brandKey: brandKey,
      build: () {
        final preset =
            _registry.get(presetId) ??
            _registry.get(
              effectiveBrightness == Brightness.light
                  ? ThemeDefaults.fallbackLightPresetId
                  : ThemeDefaults.fallbackDarkPresetId,
            );

        assert(preset != null, 'No fallback preset registered in registry.');

        final BrandColorSelection brand = switch (config) {
          // SystemBased: cho phép override brand
          SystemBasedThemeConfig c => BrandDefaults.resolve(c.brandId),
          // PresetBased: dùng brand từ preset (không override)
          PresetBasedThemeConfig _ => preset!.brand,
        };

        return AppThemeBuilder.buildForPreset(
          preset: preset!,
          brightness: effectiveBrightness,
          brandOverride: brand,
        );
      },
    );
  }

  void invalidateCache({String? presetId}) =>
      _cache.invalidate(presetId: presetId);
}
