import 'package:flutter/material.dart';
import '../../../themes/index.dart';
import '../glass_container.dart';

class Top3Section extends StatelessWidget {
  const Top3Section({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOP 3',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: SaintColors.primary,
            shadows: [
              Shadow(
                color: SaintColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SaintColors.primary, SaintColors.secondary],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: SaintColors.primary.withValues(alpha: 0.4),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: List.generate(
            3,
                (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < 2 ? 16 : 0,
                ),
                child: _buildTop3Item(index + 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTop3Item(int number) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Item $number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SaintColors.primary,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [SaintColors.primary, SaintColors.secondary],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SaintColors.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: SaintColors.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
