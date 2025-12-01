import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../glass_container.dart';
import '../../../themes/index.dart';

class ProductionSection extends StatelessWidget {
  final MovieDetails movie;

  const ProductionSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compañías Productoras',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: SaintColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: movie.productionCompaniesNames!.map((companyName) {
              return GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.business,
                      size: 16,
                      color: SaintColors.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      companyName,
                      style: TextStyle(
                        fontSize: 14,
                        color: SaintColors.foreground,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
