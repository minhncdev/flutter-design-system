// core/design_system/src/components/data_display/app_icon_container.dart
//
// DS Icon container primitive.
// - Matches the recurring “icon inside rounded square” pattern from the HTML.
// - Theme/token-driven via Material 3 ColorScheme + DS spacing/radii.
// - Compose-friendly: can be used standalone or as leading widget in AppListTile.
// - No business logic; purely presentational.

library;

import 'package:flutter/material.dart';

import '../../foundations/app_spacing.dart';
import '../../theme/theme_extensions/ds_extensions.dart';

enum AppIconContainerSize { sm, md, lg }

enum AppIconContainerTone { neutral, info, success, warning, danger }

@immutable
class AppIconContainer extends StatelessWidget {
  /// Prefer using [icon] for consistency with Material icons.
  final IconData? icon;

  /// Use [child] when you need a custom widget (SVG, image, etc).
  ///
  /// If both [icon] and [child] are provided, [child] wins.
  final Widget? child;

  final AppIconContainerSize size;
  final AppIconContainerTone tone;

  /// Adds a subtle outline (useful when the background is close to the surface).
  final bool outlined;

  final String? semanticsLabel;

  const AppIconContainer({
    super.key,
    this.icon,
    this.child,
    this.size = AppIconContainerSize.md,
    this.tone = AppIconContainerTone.neutral,
    this.outlined = true,
    this.semanticsLabel,
  }) : assert(icon != null || child != null, 'Provide either icon or child');

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = context.dsSpacing.spacing;

    final _ToneColors c = _resolveTone(scheme, tone);

    final double boxSize = _boxSizeFor(s, size);
    final double iconSize = _iconSizeFor(s, size);

    final BorderRadius radius = context.dsRadii.circular(
      context.dsRadii.shape.lg,
    );

    final Widget content = Center(
      child: child ?? Icon(icon, size: iconSize, color: c.foreground),
    );

    return Semantics(
      label: semanticsLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c.background,
          borderRadius: radius,
          border: outlined ? Border.all(color: scheme.outlineVariant) : null,
        ),
        child: SizedBox.square(dimension: boxSize, child: content),
      ),
    );
  }

  double _boxSizeFor(AppSpacing s, AppIconContainerSize size) {
    switch (size) {
      case AppIconContainerSize.sm:
        return s.xl + s.sm; // 24 + 8 = 32
      case AppIconContainerSize.md:
        return s.x2l + s.sm; // 32 + 8 = 40
      case AppIconContainerSize.lg:
        return s.x2l + s.lg; // 32 + 16 = 48
    }
  }

  double _iconSizeFor(AppSpacing s, AppIconContainerSize size) {
    switch (size) {
      case AppIconContainerSize.sm:
        return s.lg; // 16
      case AppIconContainerSize.md:
        return s.xl; // 24
      case AppIconContainerSize.lg:
        return s.xl; // 24
    }
  }

  _ToneColors _resolveTone(ColorScheme scheme, AppIconContainerTone tone) {
    switch (tone) {
      case AppIconContainerTone.neutral:
        return _ToneColors(
          background: scheme.surfaceContainerHighest,
          foreground: scheme.onSurface,
        );
      case AppIconContainerTone.info:
        return _ToneColors(
          background: scheme.primaryContainer,
          foreground: scheme.onPrimaryContainer,
        );
      case AppIconContainerTone.success:
        return _ToneColors(
          background: scheme.secondaryContainer,
          foreground: scheme.onSecondaryContainer,
        );
      case AppIconContainerTone.warning:
        return _ToneColors(
          background: scheme.tertiaryContainer,
          foreground: scheme.onTertiaryContainer,
        );
      case AppIconContainerTone.danger:
        return _ToneColors(
          background: scheme.errorContainer,
          foreground: scheme.onErrorContainer,
        );
    }
  }
}

@immutable
class _ToneColors {
  final Color background;
  final Color foreground;

  const _ToneColors({required this.background, required this.foreground});
}
