/// Semantic color foundations (built from primitive palettes).
/// - Consumes only tokens (PrimitivePalettes/ColorScale).
/// - Exposes semantic roles for UI (no ThemeData / no ColorScheme here).
/// - Designed to be wrapped as ThemeExtension at theme layer.
library;

import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';

import '../tokens/color_palette.dart';
import 'semantic_mapping_profile.dart';

@immutable
class BrandColorSelection {
  /// Which primitive scales this brand uses for key accents.
  /// Mapping to semantic roles happens in [AppColors.fromBrand].
  final ColorScale primary;
  final ColorScale secondary;
  final ColorScale accent;

  /// Status scales are usually shared across brands, but can be overridden.
  final ColorScale success;
  final ColorScale warning;
  final ColorScale danger;
  final ColorScale info;

  const BrandColorSelection({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  /// Default: uses base palettes (blue/teal/purple + standard status scales).
  static const BrandColorSelection base = BrandColorSelection(
    primary: PrimitivePalettes.blueScale,
    secondary: PrimitivePalettes.tealScale,
    accent: PrimitivePalettes.purpleScale,
    success: PrimitivePalettes.greenScale,
    warning: PrimitivePalettes.amberScale,
    danger: PrimitivePalettes.redScale,
    info: PrimitivePalettes.blueScale,
  );

  // Example brand selections (token-driven).
  // Keep these as simple preset options; apps can define more if needed.

  static const BrandColorSelection green = BrandColorSelection(
    primary: PrimitivePalettes.greenScale,
    secondary: PrimitivePalettes.tealScale,
    accent: PrimitivePalettes.blueScale,
    success: PrimitivePalettes.greenScale,
    warning: PrimitivePalettes.amberScale,
    danger: PrimitivePalettes.redScale,
    info: PrimitivePalettes.blueScale,
  );

  /// Brand extracted from HTML mocks (neon green + custom warning/danger).
  static const BrandColorSelection fintechGreen = BrandColorSelection(
    primary: PrimitivePalettes.greenNeonScale,
    secondary: PrimitivePalettes.tealScale,
    accent: PrimitivePalettes.blueScale,
    success: PrimitivePalettes.greenNeonScale,
    warning: PrimitivePalettes.amberFinanceScale,
    danger: PrimitivePalettes.redFinanceScale,
    info: PrimitivePalettes.blueScale,
  );

  static const BrandColorSelection blue = BrandColorSelection.base;
}

/// Semantic colors for the app.
/// Keep this set stable and versioned for multi-team scalability.
@immutable
class AppColors {
  // Surfaces & backgrounds
  final Color background;
  final Color surface;
  final Color surfaceSubtle;
  final Color surfaceElevated;

  // Content
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color iconPrimary;
  final Color iconSecondary;

  // Borders & dividers
  final Color border;
  final Color divider;

  // Brand accents
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  final Color accent;
  final Color onAccent;

  // Status
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;

  final Color danger;
  final Color onDanger;
  final Color dangerContainer;
  final Color onDangerContainer;

  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;

  // States
  final Color focusRing;
  final Color disabled;
  final Color onDisabled;

  // Scrims/overlays (raw colors; actual opacity usage belongs to UI/theme)
  final Color scrim;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.surfaceElevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.border,
    required this.divider,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.danger,
    required this.onDanger,
    required this.dangerContainer,
    required this.onDangerContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.focusRing,
    required this.disabled,
    required this.onDisabled,
    required this.scrim,
  });

  /// Brand-based semantic mapping for Light theme.
  factory AppColors.light({
    required PrimitivePalettes palettes,
    required BrandColorSelection brand,
    AppSemanticMappingProfile mappingProfile =
        AppSemanticMappingProfiles.material3,
  }) {
    final n = palettes.neutral;
    final nn = mappingProfile.lightNeutral;
    final br = mappingProfile.lightBrand;
    final bc = mappingProfile.lightContainers;

    return AppColors(
      background: n[nn.background],
      surface: n[nn.surface],
      surfaceSubtle: n[nn.surfaceSubtle],
      surfaceElevated: n[nn.surfaceElevated],

      textPrimary: n[nn.textPrimary],
      textSecondary: n[nn.textSecondary],
      textTertiary: n[nn.textTertiary],
      iconPrimary: n[nn.iconPrimary],
      iconSecondary: n[nn.iconSecondary],

      border: n[nn.border],
      divider: n[nn.divider],

      primary: brand.primary[br.primary],
      onPrimary: n[nn.surface],
      primaryContainer: brand.primary[bc.primaryContainer],
      onPrimaryContainer: brand.primary[900],

      secondary: brand.secondary[br.secondary],
      onSecondary: n[nn.surface],
      secondaryContainer: brand.secondary[bc.secondaryContainer],
      onSecondaryContainer: brand.secondary[900],

      accent: brand.accent[br.accent],
      onAccent: n[nn.surface],

      success: brand.success[br.success],
      onSuccess: n[nn.surface],
      successContainer: brand.success[bc.successContainer],
      onSuccessContainer: brand.success[900],

      warning: brand.warning[br.warning],
      onWarning: n[nn.scrim],
      warningContainer: brand.warning[bc.warningContainer],
      onWarningContainer: brand.warning[900],

      danger: brand.danger[br.danger],
      onDanger: n[nn.surface],
      dangerContainer: brand.danger[bc.dangerContainer],
      onDangerContainer: brand.danger[900],

      info: brand.info[br.info],
      onInfo: n[nn.surface],
      infoContainer: brand.info[bc.infoContainer],
      onInfoContainer: brand.info[900],

      focusRing: brand.primary[br.primary],
      disabled: n[nn.disabled],
      onDisabled: n[nn.onDisabled],

      scrim: n[nn.scrim],
    );
  }

  /// Brand-based semantic mapping for Dark theme.
  factory AppColors.dark({
    required PrimitivePalettes palettes,
    required BrandColorSelection brand,
    AppSemanticMappingProfile mappingProfile =
        AppSemanticMappingProfiles.material3,
  }) {
    final n = palettes.neutral;
    final nn = mappingProfile.darkNeutral;
    final br = mappingProfile.darkBrand;
    final bc = mappingProfile.darkContainers;

    return AppColors(
      background: n[nn.background],
      surface: n[nn.surface],
      surfaceSubtle: n[nn.surfaceSubtle],
      surfaceElevated: n[nn.surfaceElevated],

      textPrimary: n[nn.textPrimary],
      textSecondary: n[nn.textSecondary],
      textTertiary: n[nn.textTertiary],
      iconPrimary: n[nn.iconPrimary],
      iconSecondary: n[nn.iconSecondary],

      border: n[nn.border],
      divider: n[nn.divider],

      primary: brand.primary[br.primary],
      onPrimary: n[nn.background],
      primaryContainer: brand.primary[bc.primaryContainer],
      onPrimaryContainer: n[nn.textPrimary],

      secondary: brand.secondary[br.secondary],
      onSecondary: n[nn.background],
      secondaryContainer: brand.secondary[bc.secondaryContainer],
      onSecondaryContainer: n[nn.textPrimary],

      accent: brand.accent[br.accent],
      onAccent: n[nn.background],

      success: brand.success[br.success],
      onSuccess: n[nn.background],
      successContainer: brand.success[bc.successContainer],
      onSuccessContainer: n[nn.textPrimary],

      warning: brand.warning[br.warning],
      onWarning: n[nn.background],
      warningContainer: brand.warning[bc.warningContainer],
      onWarningContainer: n[nn.textPrimary],

      danger: brand.danger[br.danger],
      onDanger: n[nn.background],
      dangerContainer: brand.danger[bc.dangerContainer],
      onDangerContainer: n[nn.textPrimary],

      info: brand.info[br.info],
      onInfo: n[nn.background],
      infoContainer: brand.info[bc.infoContainer],
      onInfoContainer: n[nn.textPrimary],

      focusRing: brand.primary[br.primary],
      disabled: n[nn.disabled],
      onDisabled: n[nn.onDisabled],

      scrim: n[nn.scrim],
    );
  }

  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSubtle,
    Color? surfaceElevated,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? border,
    Color? divider,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? danger,
    Color? onDanger,
    Color? dangerContainer,
    Color? onDangerContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? focusRing,
    Color? disabled,
    Color? onDisabled,
    Color? scrim,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      onDangerContainer: onDangerContainer ?? this.onDangerContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      focusRing: focusRing ?? this.focusRing,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      scrim: scrim ?? this.scrim,
    );
  }

  AppColors lerp(AppColors other, double t) {
    Color l(Color a, Color b) => Color.lerp(a, b, t) ?? b;

    return AppColors(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceSubtle: l(surfaceSubtle, other.surfaceSubtle),
      surfaceElevated: l(surfaceElevated, other.surfaceElevated),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      iconPrimary: l(iconPrimary, other.iconPrimary),
      iconSecondary: l(iconSecondary, other.iconSecondary),
      border: l(border, other.border),
      divider: l(divider, other.divider),
      primary: l(primary, other.primary),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryContainer: l(primaryContainer, other.primaryContainer),
      onPrimaryContainer: l(onPrimaryContainer, other.onPrimaryContainer),
      secondary: l(secondary, other.secondary),
      onSecondary: l(onSecondary, other.onSecondary),
      secondaryContainer: l(secondaryContainer, other.secondaryContainer),
      onSecondaryContainer: l(onSecondaryContainer, other.onSecondaryContainer),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      success: l(success, other.success),
      onSuccess: l(onSuccess, other.onSuccess),
      successContainer: l(successContainer, other.successContainer),
      onSuccessContainer: l(onSuccessContainer, other.onSuccessContainer),
      warning: l(warning, other.warning),
      onWarning: l(onWarning, other.onWarning),
      warningContainer: l(warningContainer, other.warningContainer),
      onWarningContainer: l(onWarningContainer, other.onWarningContainer),
      danger: l(danger, other.danger),
      onDanger: l(onDanger, other.onDanger),
      dangerContainer: l(dangerContainer, other.dangerContainer),
      onDangerContainer: l(onDangerContainer, other.onDangerContainer),
      info: l(info, other.info),
      onInfo: l(onInfo, other.onInfo),
      infoContainer: l(infoContainer, other.infoContainer),
      onInfoContainer: l(onInfoContainer, other.onInfoContainer),
      focusRing: l(focusRing, other.focusRing),
      disabled: l(disabled, other.disabled),
      onDisabled: l(onDisabled, other.onDisabled),
      scrim: l(scrim, other.scrim),
    );
  }
}
