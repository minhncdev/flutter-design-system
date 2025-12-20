/// Navigation primitive tokens (raw values only).
/// - AppBar / BottomBar / Tabs / NavigationRail raw metrics.
/// - No widgets, no padding objects.
library;

import 'package:flutter/material.dart';

import '../motion_tokens.dart'; // NEW
import '../size_tokens.dart';
import '../spacing_tokens.dart';

@immutable
class NavigationTokens {
  /// Material baseline AppBar height.
  static const double appBarHeight = 56;

  /// Bottom navigation bar height (comfortable for fintech).
  static const double bottomBarHeight = 64;

  /// Tab bar height.
  static const double tabBarHeight = 48;

  /// Navigation rail width (desktop/tablet).
  static const double navRailWidth = 80;

  /// Icon size in navigation items.
  static const double navIconSize = SizeTokens.sz24;

  /// Label/icon spacing within nav items.
  static const double itemGap = SpacingTokens.s6;

  /// Horizontal padding for nav item touch area (resolver decides final).
  static const double itemPaddingX = SpacingTokens.s12;

  // ===== NEW: BottomBar selected style =====
  /// Icon scale when selected/unselected.
  static const double bottomBarSelectedIconScale = 1.2;
  static const double bottomBarUnselectedIconScale = 1.0;

  /// Reduce icon vertical padding to 1px top/bottom.
  static const double bottomBarIconPaddingY = SpacingTokens.s1;

  /// Reduce label top padding to 1px.
  static const double bottomBarLabelPaddingTop = SpacingTokens.s1;

  /// Scale animation duration.
  static const Duration bottomBarSelectionAnimDuration = MotionDurations.fast;

  const NavigationTokens._();
}
