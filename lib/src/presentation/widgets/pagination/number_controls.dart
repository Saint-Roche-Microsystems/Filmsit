import 'package:flutter/material.dart';
import '../../../themes/index.dart';

class NumberControls extends StatelessWidget {
  final int page;
  final bool isActive;
  final VoidCallback onTap;

  const NumberControls({
    super.key,
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          color: isActive ? null : SaintColors.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? SaintColors.primary.withValues(alpha: 0.5)
                : SaintColors.primary.withValues(alpha: 0.2),
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
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? SaintColors.background
                  : SaintColors.foreground,
            ),
          ),
        ),
      ),
    );
  }
}
