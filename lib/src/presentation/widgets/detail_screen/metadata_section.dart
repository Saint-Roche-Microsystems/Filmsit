import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../glass_container.dart';
import '../../../themes/index.dart';

class MetadataSection extends StatelessWidget {
  final MovieDetails movie;

  const MetadataSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Rating
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: SaintColors.contrast,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: SaintColors.foreground,
                  ),
                ),
                Text(
                  ' / 10',
                  style: TextStyle(
                    fontSize: 14,
                    color: SaintColors.foreground.withValues(alpha: (0.6)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Fecha de estreno
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: SaintColors.secondary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '${movie.releaseDate.day}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                  style: TextStyle(
                    fontSize: 16,
                    color: SaintColors.foreground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
