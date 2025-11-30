import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../glass_container.dart';
import '../../../themes/index.dart';

class GenresSection extends StatelessWidget {
  final MovieDetails movie;

  const GenresSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Géneros',
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
            children: movie.genres!.map((genre) {
              return GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  genre.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: SaintColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
