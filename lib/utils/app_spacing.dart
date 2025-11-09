import 'package:flutter/material.dart';
import 'constants.dart';

/// Extension on EdgeInsets for consistent spacing throughout the app
extension AppSpacing on EdgeInsets {
  /// Standard app padding patterns
  static const EdgeInsets small = EdgeInsets.all(AppConstants.smallPadding);
  static const EdgeInsets medium = EdgeInsets.all(AppConstants.defaultPadding);
  static const EdgeInsets large = EdgeInsets.all(AppConstants.largePadding);
  static const EdgeInsets extraLarge = EdgeInsets.all(
    AppConstants.extraLargePadding,
  );

  /// Symmetric padding patterns
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: AppConstants.mediumPadding,
  );
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(
    vertical: AppConstants.mediumPadding,
  );
  static const EdgeInsets horizontalDefault = EdgeInsets.symmetric(
    horizontal: AppConstants.defaultPadding,
  );
  static const EdgeInsets verticalDefault = EdgeInsets.symmetric(
    vertical: AppConstants.defaultPadding,
  );

  /// Specific use-case patterns
  static const EdgeInsets cardMargin = EdgeInsets.all(
    AppConstants.mediumPadding,
  );
  static const EdgeInsets cardPadding = EdgeInsets.all(
    AppConstants.defaultPadding,
  );

  /// Icon container specific spacing
  static const EdgeInsets iconContainerMargin = EdgeInsets.only(
    top: AppConstants.extraLargePadding,
    bottom: AppConstants.mediumPadding,
    left: AppConstants.mediumPadding,
    right: AppConstants.mediumPadding,
  );

  /// Container dimensions
  static const double iconContainerSize = AppConstants.iconContainerSize;
  static const double iconSize = AppConstants.largeIconSize;
  static const double containerBorderWidth = AppConstants.borderWidth;
  static const double mediumSpacing = AppConstants.defaultPadding;

  /// Form field spacing
  static const EdgeInsets formFieldSpacing = EdgeInsets.only(
    bottom: AppConstants.defaultPadding,
  );
}
