// app/config/theme_defaults.dart
//
// App-owned mapping layer (Brightness -> PresetId).
// ✅ Đây là nơi bạn đổi default preset nhanh nhất (light/dark).

library;

import 'package:flutter/material.dart' show Brightness;

class ThemeDefaults {
  const ThemeDefaults._();

  /// Default preset IDs (mutable để bạn đổi nhanh).
  /// - SystemBased mode sẽ luôn lấy theo 2 biến này.
  static String defaultLightPresetId = 'white';
  static String defaultDarkPresetId = 'dark';

  /// Fallback nếu presetId không được register trong registry.
  static const String fallbackLightPresetId = 'white';
  static const String fallbackDarkPresetId = 'dark';

  static String presetIdForBrightness(Brightness brightness) {
    return brightness == Brightness.light
        ? defaultLightPresetId
        : defaultDarkPresetId;
  }

  /// Helper để đổi default nhanh theo code/runtime (xong gọi controller.rebuildFromDefaults()).
  static void setDefaultPresetIdForBrightness(
    Brightness brightness,
    String presetId,
  ) {
    if (brightness == Brightness.light) {
      defaultLightPresetId = presetId;
    } else {
      defaultDarkPresetId = presetId;
    }
  }
}
