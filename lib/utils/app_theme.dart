import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;
import 'constants.dart';

/// Custom theme extension for app-specific styling
@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    this.spacing = const AppSpacingTheme(),
    this.containers = const AppContainerTheme(),
  });

  final AppSpacingTheme spacing;
  final AppContainerTheme containers;

  @override
  AppTheme copyWith({
    AppSpacingTheme? spacing,
    AppContainerTheme? containers,
  }) {
    return AppTheme(
      spacing: spacing ?? this.spacing,
      containers: containers ?? this.containers,
    );
  }

  @override
  AppTheme lerp(AppTheme? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      spacing: spacing.lerp(other.spacing, t),
      containers: containers.lerp(other.containers, t),
    );
  }

  /// Access the theme from context
  static AppTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTheme>() ?? const AppTheme();
  }
}

/// Spacing theme
@immutable
class AppSpacingTheme {
  const AppSpacingTheme({
    this.small = AppConstants.smallPadding,
    this.medium = AppConstants.defaultPadding,
    this.large = AppConstants.largePadding,
    this.extraLarge = AppConstants.extraLargePadding,
    this.mediumValue = AppConstants.mediumPadding,
  });

  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double mediumValue;

  // Predefined EdgeInsets
  EdgeInsets get iconContainerMargin => EdgeInsets.only(
        top: extraLarge,
        bottom: mediumValue,
        left: mediumValue,
        right: mediumValue,
      );

  EdgeInsets get cardMargin => EdgeInsets.all(mediumValue);
  EdgeInsets get cardPadding => EdgeInsets.all(medium);
  EdgeInsets get formSpacing => EdgeInsets.only(bottom: medium);

  AppSpacingTheme lerp(AppSpacingTheme other, double t) {
    return AppSpacingTheme(
      small: lerpDouble(small, other.small, t) ?? small,
      medium: lerpDouble(medium, other.medium, t) ?? medium,
      large: lerpDouble(large, other.large, t) ?? large,
      extraLarge: lerpDouble(extraLarge, other.extraLarge, t) ?? extraLarge,
      mediumValue: lerpDouble(mediumValue, other.mediumValue, t) ?? mediumValue,
    );
  }
}

/// Container theme
@immutable
class AppContainerTheme {
  const AppContainerTheme({
    this.iconSize = AppConstants.iconContainerSize,
    this.borderWidth = AppConstants.borderWidth,
    this.borderRadius = AppConstants.borderRadius,
  });

  final double iconSize;
  final double borderWidth;
  final double borderRadius;

  AppContainerTheme lerp(AppContainerTheme other, double t) {
    return AppContainerTheme(
      iconSize: lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }
}