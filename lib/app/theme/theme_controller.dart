// app/theme/theme_controller.dart
//
// App-shell theme controller (no feature logic).
// - Owns ThemeSelectionConfig
// - Rebuilds only what changed (light/dark) using ThemeResolver + cache
// - Designed so "default tone" can be changed by app config (ThemeDefaults).

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';
import '../config/theme_defaults.dart';
import '../config/brand_defaults.dart';
import 'theme_resolver.dart';
import 'theme_selection_config.dart';
import 'theme_state.dart';

class ThemeController extends ChangeNotifier {
  final ThemeResolver _resolver;

  ThemeState _state;

  ThemeController({ThemeResolver? resolver})
    : _resolver = resolver ?? ThemeResolver(),
      _state = ThemeState(
        config: const SystemBasedThemeConfig(),
        lightTheme: ThemeData(),
        darkTheme: ThemeData(),
        themeMode: ThemeMode.system,
      ) {
    _rebuildAll(); // initialize themes
  }

  ThemeState get state => _state;

  // ---------- Public API ----------

  void setSelectionType(ThemeSelectionType type) {
    final ThemeSelectionConfig next = switch (type) {
      ThemeSelectionType.systemBased => const SystemBasedThemeConfig(),
      ThemeSelectionType.brandBased => () {
        final presetId = ThemeDefaults.defaultLightPresetId;
        final preset = ThemePaletteRegistry.instance.get(presetId);
        final tone = preset?.toneBrightness ?? Brightness.light;
        return PresetBasedThemeConfig(presetId: presetId, toneBrightness: tone);
      }(),
    };

    _state = _stateForConfig(next);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    final cfg = _state.config;
    if (cfg is! SystemBasedThemeConfig) return;

    final updated = cfg.copyWith(mode: mode);
    _state = ThemeState(
      config: updated,
      lightTheme: _state.lightTheme,
      darkTheme: _state.darkTheme,
      themeMode: updated.mode,
    );
    notifyListeners();
  }

  /// (4) Chỉ cho phép đổi brand khi đang SystemBased.
  void setBrandColor(String brandId) {
    final cfg = _state.config;
    if (cfg is! SystemBasedThemeConfig) return;

    final updated = cfg.copyWith(brandId: brandId);
    _state = _stateForConfig(updated);
    notifyListeners();
  }

  /// (2)(3) Preset mode: chọn preset -> đổi màu ngay lập tức và ép tone theo preset.
  void setPalettePreset(String presetId) {
    final cfg = _state.config;
    if (cfg is! PresetBasedThemeConfig) return;

    final preset = ThemePaletteRegistry.instance.get(presetId);
    final tone = preset?.toneBrightness ?? Brightness.light;

    final updated = cfg.copyWith(presetId: presetId, toneBrightness: tone);
    _state = _stateForConfig(updated);
    notifyListeners();
  }

  /// Call this after changing defaults mapping (typically on app restart).
  void rebuildFromDefaults() {
    _rebuildAll();
    notifyListeners();
  }

  // ---------- Internal ----------

  void _rebuildAll() {
    final cfg = _state.config;
    _state = _stateForConfig(cfg);
  }

  ThemeState _stateForConfig(ThemeSelectionConfig cfg) {
    return switch (cfg) {
      SystemBasedThemeConfig c => ThemeState(
        config: c,
        lightTheme: _resolver.buildTheme(c, Brightness.light),
        darkTheme: _resolver.buildTheme(c, Brightness.dark),
        themeMode: c.mode,
      ),
      PresetBasedThemeConfig c => () {
        // Preset chỉ có 1 tone -> build 1 theme và gán cho cả light/dark.
        final t = _resolver.buildTheme(c, c.toneBrightness);
        final m = c.toneBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
        return ThemeState(config: c, lightTheme: t, darkTheme: t, themeMode: m);
      }(),
    };
  }
}
