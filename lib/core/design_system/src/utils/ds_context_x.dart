// core/design_system/src/utils/ds_context_x.dart
//
// DS context extensions.
// - Convenience accessors for Material Theme objects only.
// - IMPORTANT: Do NOT duplicate DS theme-extension getters (dsSpacing/dsRadii/...)
//   to avoid ambiguous_extension_member_access with theme_extensions/ds_extensions.dart.

library;

import 'package:flutter/material.dart';

extension DsContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => theme.colorScheme;

  TextTheme get text => theme.textTheme;

  MediaQueryData get mq => MediaQuery.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;
}
