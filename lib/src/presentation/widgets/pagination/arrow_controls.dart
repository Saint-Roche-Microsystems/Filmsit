import 'package:flutter/material.dart';
import '../../../themes/index.dart';

class ArrowControls extends StatelessWidget {
  final IconData icon;
  final bool Function() isActiveCallback;
  final VoidCallback onTap;

  const ArrowControls({
    super.key,
    required this.icon,
    required this.isActiveCallback,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = isActiveCallback();

    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [SaintColors.secondary, SaintColors.secondary],
          )
              : null,
          color: isActive ? null : SaintColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? SaintColors.primary.withValues(alpha: 0.5)
                : SaintColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: SaintColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive
              ? SaintColors.background
              : SaintColors.foreground.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
