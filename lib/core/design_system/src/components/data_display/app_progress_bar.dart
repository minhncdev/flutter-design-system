// core/design_system/src/components/data_display/app_progress_bar.dart
//
// DS Progress bar primitive (linear).
// - Used in the HTML for budgets, category usage, debt repayment, etc.
// - Token/theme-driven via Material 3 ColorScheme + DS spacing/radii.
// - Pure UI: callers provide value (0..1) and optional semantics.

library;

import 'package:flutter/material.dart';

import '../../theme/theme_extensions/ds_extensions.dart';

enum AppProgressTone { primary, success, warning, danger, neutral }

@immutable
class AppProgressBar extends StatelessWidget {
  /// Progress from 0.0 to 1.0 (clamped).
  final double value;

  final AppProgressTone tone;

  /// Optional override; defaults to DS spacing token (sm).
  final double? height;

  /// Optional label for accessibility.
  final String? semanticsLabel;

  const AppProgressBar({
    super.key,
    required this.value,
    this.tone = AppProgressTone.primary,
    this.height,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = context.dsSpacing.spacing;

    final double v = value.clamp(0.0, 1.0);
    final double h = height ?? s.sm; // 8

    final Color track = scheme.surfaceContainerHighest;
    final Color fill = _resolveTone(scheme, tone);

    final BorderRadius radius = context.dsRadii.circular(
      context.dsRadii.shape.full,
    );

    final String percent = '${(v * 100).round()}%';

    return Semantics(
      label: semanticsLabel,
      value: percent,
      child: ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          height: h,
          child: DecoratedBox(
            decoration: BoxDecoration(color: track),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double w = constraints.maxWidth * v;
                return Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: w,
                    child: DecoratedBox(decoration: BoxDecoration(color: fill)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Color _resolveTone(ColorScheme scheme, AppProgressTone tone) {
    switch (tone) {
      case AppProgressTone.primary:
        return scheme.primary;
      case AppProgressTone.success:
        return scheme.secondary;
      case AppProgressTone.warning:
        return scheme.tertiary;
      case AppProgressTone.danger:
        return scheme.error;
      case AppProgressTone.neutral:
        return scheme.onSurfaceVariant;
    }
  }
}
