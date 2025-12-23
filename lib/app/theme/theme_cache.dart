// app/theme/theme_cache.dart
//
// Small cache for ThemeData built from presetId + brightness.

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeCacheKey {
  final String presetId;
  final Brightness brightness;
  final String brandKey;

  const ThemeCacheKey(this.presetId, this.brightness, this.brandKey);

  @override
  bool operator ==(Object other) =>
      other is ThemeCacheKey &&
      other.presetId == presetId &&
      other.brightness == brightness &&
      other.brandKey == brandKey;

  @override
  int get hashCode => Object.hash(presetId, brightness, brandKey);
}

class ThemeCache {
  final Map<ThemeCacheKey, ThemeData> _cache = <ThemeCacheKey, ThemeData>{};

  ThemeData getOrBuild({
    required String presetId,
    required Brightness brightness,
    required String brandKey,
    required ThemeData Function() build,
  }) {
    final key = ThemeCacheKey(presetId, brightness, brandKey);
    final hit = _cache[key];
    if (hit != null) return hit;

    final built = build();
    _cache[key] = built;
    return built;
  }

  void invalidate({String? presetId, String? brandKey}) {
    if (presetId == null && brandKey == null) {
      _cache.clear();
      return;
    }
    _cache.removeWhere((k, _) {
      final matchPreset = presetId == null || k.presetId == presetId;
      final matchBrand = brandKey == null || k.brandKey == brandKey;
      return matchPreset && matchBrand;
    });
  }

  @visibleForTesting
  void clear() => _cache.clear();
}
