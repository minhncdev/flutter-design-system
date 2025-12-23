// core/design_system/src/components/inputs/app_segmented_control.dart
//
// DS Segmented control primitive.
// - Matches the pill/segmented filters in the HTML (e.g., time range, tabs).
// - Wraps Material 3 SegmentedButton with DS spacing/radii + ColorScheme mapping.
// - Pure UI: caller owns the state (selected value).

library;

import 'package:flutter/material.dart';

import '../../theme/theme_extensions/ds_extensions.dart';

@immutable
class AppSegment<T> {
  final T value;
  final String label;
  final IconData? icon;

  const AppSegment({required this.value, required this.label, this.icon});
}

@immutable
class AppSegmentedControl<T> extends StatelessWidget {
  final List<AppSegment<T>> segments;

  /// Selected value (single selection).
  final T value;

  /// Called when user picks a segment.
  final ValueChanged<T> onChanged;

  final bool enabled;

  /// Expand to full width (common in mobile filters).
  final bool fullWidth;

  /// Optional a11y label for the whole control.
  final String? semanticsLabel;

  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.fullWidth = true,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = context.dsSpacing.spacing;

    final BorderRadius radius = context.dsRadii.circular(
      context.dsRadii.shape.full,
    );

    final ButtonStyle style = ButtonStyle(
      // Size/padding tuned to match the HTML pills while remaining token-driven.
      minimumSize: MaterialStatePropertyAll<Size>(
        Size(0, s.x2l + s.sm), // 32 + 8 = 40
      ),
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
        context.dsSpacing.symmetric(horizontal: s.md, vertical: s.sm),
      ),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: radius),
      ),
      side: MaterialStatePropertyAll<BorderSide>(
        BorderSide(color: scheme.outlineVariant),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) return scheme.primary;
        return scheme.surfaceContainerHighest;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) return scheme.onPrimary;
        return scheme.onSurface;
      }),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return scheme.primary.withOpacity(0.12);
        }
        return null;
      }),
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        Theme.of(context).textTheme.labelLarge,
      ),
    );

    final control = SegmentedButton<T>(
      segments: segments
          .map(
            (s) => ButtonSegment<T>(
              value: s.value,
              label: Text(s.label),
              icon: s.icon != null ? Icon(s.icon) : null,
            ),
          )
          .toList(growable: false),
      selected: <T>{value},
      onSelectionChanged: enabled
          ? (set) {
              if (set.isEmpty) return;
              onChanged(set.first);
            }
          : null,
      showSelectedIcon: false,
      style: style,
    );

    return Semantics(
      label: semanticsLabel,
      child: fullWidth
          ? SizedBox(width: double.infinity, child: control)
          : control,
    );
  }
}
