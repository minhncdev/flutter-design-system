// core/design_system/src/components/data_display/app_badge_dot.dart
//
// DS Badge primitives.
// - Used for notification dots in the HTML header/actions.
// - Compose-friendly: AppBadged can wrap any widget (icon button, avatar, ...).
// - Token/theme-driven (ColorScheme + DS spacing/radii).
// - No business logic.

library;

import 'package:flutter/material.dart';

import '../../foundations/app_spacing.dart';
import '../../theme/theme_extensions/ds_extensions.dart';

enum AppBadgeDotSize { sm, md }

enum AppBadgeTone { neutral, primary, success, warning, danger }

enum AppBadgeAlignment { topStart, topEnd, bottomStart, bottomEnd }

@immutable
class AppBadgeDot extends StatelessWidget {
  final AppBadgeDotSize size;
  final AppBadgeTone tone;

  /// Adds a separating border, useful when the badge sits on bright surfaces.
  final bool bordered;

  final String? semanticsLabel;

  const AppBadgeDot({
    super.key,
    this.size = AppBadgeDotSize.md,
    this.tone = AppBadgeTone.primary,
    this.bordered = true,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = context.dsSpacing.spacing;

    final double d = _dotSizeFor(s, size);

    final Color color = _resolveTone(scheme, tone);
    final Color border = scheme.surface;

    return Semantics(
      label: semanticsLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: bordered ? Border.all(color: border, width: s.xxs) : null,
        ),
        child: SizedBox.square(dimension: d),
      ),
    );
  }

  double _dotSizeFor(AppSpacing s, AppBadgeDotSize size) {
    switch (size) {
      case AppBadgeDotSize.sm:
        return s.xs + s.xxs; // 4 + 2 = 6
      case AppBadgeDotSize.md:
        return s.sm; // 8
    }
  }

  Color _resolveTone(ColorScheme scheme, AppBadgeTone tone) {
    switch (tone) {
      case AppBadgeTone.neutral:
        return scheme.onSurfaceVariant;
      case AppBadgeTone.primary:
        return scheme.primary;
      case AppBadgeTone.success:
        return scheme.secondary;
      case AppBadgeTone.warning:
        return scheme.tertiary;
      case AppBadgeTone.danger:
        return scheme.error;
    }
  }
}

@immutable
class AppBadged extends StatelessWidget {
  final Widget child;

  /// If null, defaults to a small [AppBadgeDot].
  final Widget? badge;

  final bool showBadge;

  final AppBadgeAlignment alignment;

  const AppBadged({
    super.key,
    required this.child,
    this.badge,
    this.showBadge = true,
    this.alignment = AppBadgeAlignment.topEnd,
  });

  @override
  Widget build(BuildContext context) {
    if (!showBadge) return child;

    final s = context.dsSpacing.spacing;

    final Widget badgeWidget =
        badge ?? const AppBadgeDot(size: AppBadgeDotSize.sm);

    // Offset the badge slightly outward (common in notification icons).
    final double offset = s.xxs;

    final (double? top, double? bottom, double? start, double? end) = _pos(
      alignment,
      offset,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child,
        PositionedDirectional(
          top: top,
          bottom: bottom,
          start: start,
          end: end,
          child: badgeWidget,
        ),
      ],
    );
  }

  (double?, double?, double?, double?) _pos(
    AppBadgeAlignment a,
    double offset,
  ) {
    switch (a) {
      case AppBadgeAlignment.topStart:
        return (-offset, null, -offset, null);
      case AppBadgeAlignment.topEnd:
        return (-offset, null, null, -offset);
      case AppBadgeAlignment.bottomStart:
        return (null, -offset, -offset, null);
      case AppBadgeAlignment.bottomEnd:
        return (null, -offset, null, -offset);
    }
  }
}
