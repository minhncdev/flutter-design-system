/// Semantic mapping profile for choosing shade keys from:
/// - Neutral scale (background/surface/text/border/disabled/scrim)
/// - Brand selections (primary/success/warning/danger...)
/// - Brand containers (primaryContainer/dangerContainer...)
///
/// Goal: keep ONE build pipeline, but allow presets to tune shade indices.
///
/// Supported keys: 0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950.
/// Unknown keys fallback to 500 by ColorScale.shade().
library;

import 'package:flutter/foundation.dart';

@immutable
class AppBrandShadeMapping {
  final int primary;
  final int secondary;
  final int accent;

  final int success;
  final int warning;
  final int danger;
  final int info;

  const AppBrandShadeMapping({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  static const AppBrandShadeMapping lightDefaults = AppBrandShadeMapping(
    primary: 600,
    secondary: 600,
    accent: 600,
    success: 600,
    warning: 600,
    danger: 600,
    info: 600,
  );

  static const AppBrandShadeMapping darkDefaults = AppBrandShadeMapping(
    primary: 400,
    secondary: 400,
    accent: 400,
    success: 400,
    warning: 400,
    danger: 400,
    info: 400,
  );
}

@immutable
class AppBrandContainerShadeMapping {
  final int primaryContainer;
  final int secondaryContainer;
  final int successContainer;
  final int warningContainer;
  final int dangerContainer;
  final int infoContainer;

  const AppBrandContainerShadeMapping({
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.successContainer,
    required this.warningContainer,
    required this.dangerContainer,
    required this.infoContainer,
  });

  static const AppBrandContainerShadeMapping lightDefaults =
      AppBrandContainerShadeMapping(
        primaryContainer: 100,
        secondaryContainer: 100,
        successContainer: 100,
        warningContainer: 100,
        dangerContainer: 100,
        infoContainer: 100,
      );

  static const AppBrandContainerShadeMapping darkDefaults =
      AppBrandContainerShadeMapping(
        primaryContainer: 700,
        secondaryContainer: 700,
        successContainer: 700,
        warningContainer: 700,
        dangerContainer: 700,
        infoContainer: 700,
      );
}

@immutable
class AppNeutralShadeMapping {
  // Surfaces
  final int background;
  final int surface;
  final int surfaceSubtle;
  final int surfaceElevated;

  // Content
  final int textPrimary;
  final int textSecondary;
  final int textTertiary;
  final int iconPrimary;
  final int iconSecondary;

  // Lines
  final int border;
  final int divider;

  // States
  final int disabled;
  final int onDisabled;

  // Overlays
  final int scrim;

  const AppNeutralShadeMapping({
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
    required this.disabled,
    required this.onDisabled,
    required this.scrim,
  });

  static const AppNeutralShadeMapping lightDefaults = AppNeutralShadeMapping(
    background: 0,
    surface: 0,
    surfaceSubtle: 50,
    surfaceElevated: 0,
    textPrimary: 900,
    textSecondary: 700,
    textTertiary: 500,
    iconPrimary: 800,
    iconSecondary: 600,
    border: 200,
    divider: 200,
    disabled: 200,
    onDisabled: 500,
    scrim: 950,
  );

  static const AppNeutralShadeMapping darkDefaults = AppNeutralShadeMapping(
    background: 950,
    surface: 900,
    surfaceSubtle: 900,
    surfaceElevated: 800,
    textPrimary: 50,
    textSecondary: 200,
    textTertiary: 400,
    iconPrimary: 100,
    iconSecondary: 300,
    border: 700,
    divider: 700,
    disabled: 800,
    onDisabled: 500,
    scrim: 950,
  );
}

@immutable
class AppSemanticMappingProfile {
  final AppBrandShadeMapping lightBrand;
  final AppBrandShadeMapping darkBrand;

  final AppBrandContainerShadeMapping lightContainers;
  final AppBrandContainerShadeMapping darkContainers;

  final AppNeutralShadeMapping lightNeutral;
  final AppNeutralShadeMapping darkNeutral;

  const AppSemanticMappingProfile({
    this.lightBrand = AppBrandShadeMapping.lightDefaults,
    this.darkBrand = AppBrandShadeMapping.darkDefaults,
    this.lightContainers = AppBrandContainerShadeMapping.lightDefaults,
    this.darkContainers = AppBrandContainerShadeMapping.darkDefaults,
    this.lightNeutral = AppNeutralShadeMapping.lightDefaults,
    this.darkNeutral = AppNeutralShadeMapping.darkDefaults,
  });
}

abstract final class AppSemanticMappingProfiles {
  const AppSemanticMappingProfiles._();

  /// Current DS behavior (matches AppColors.light/dark hard-coded keys).
  static const AppSemanticMappingProfile material3 =
      AppSemanticMappingProfile();

  /// Fintech: keep dark brand at 400, but use 500 in light to match your extracted
  /// HTML "hero" colors (green/warning/danger are at 500 in those scales).
  static const AppSemanticMappingProfile fintech = AppSemanticMappingProfile(
    lightBrand: AppBrandShadeMapping(
      primary: 500,
      secondary: 600,
      accent: 600,
      success: 500,
      warning: 500,
      danger: 500,
      info: 600,
    ),
  );
}
