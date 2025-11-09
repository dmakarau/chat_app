import 'package:flutter/material.dart';
import '../../utils/app_spacing.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: AppSpacing.iconContainerMargin,
      width: AppSpacing.iconContainerSize,
      height: AppSpacing.iconContainerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: AppSpacing.containerBorderWidth,
        ),
      ),
      child: Icon(
        Icons.forum,
        size: AppSpacing.iconSize,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
