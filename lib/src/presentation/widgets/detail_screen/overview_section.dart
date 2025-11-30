import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../glass_container.dart';
import '../../../themes/index.dart';

class OverviewSection extends StatelessWidget {
  final MovieDetails movie;

  const OverviewSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sinopsis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: SaintColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.all(16),
            child: Text(
              movie.overview.isEmpty
                  ? 'No hay sinopsis disponible'
                  : movie.overview,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: SaintColors.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
