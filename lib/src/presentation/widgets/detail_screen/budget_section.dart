import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../glass_container.dart';
import '../../../themes/index.dart';

class BudgetSection extends StatelessWidget {
  final MovieDetails movie;

  const BudgetSection({super.key, required this.movie});

  String _formatCurrency(int amount) {
    if (amount >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(2)}B';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(2)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(2)}K';
    }
    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.attach_money,
              color: SaintColors.success,
              size: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Presupuesto',
                  style: TextStyle(
                    fontSize: 14,
                    color: SaintColors.foreground.withValues(alpha: (0.6)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${_formatCurrency(movie.budget!)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: SaintColors.foreground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
