import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../../../themes/index.dart';

class DetailsMainSection extends StatelessWidget {
  final MovieDetails movie;

  const DetailsMainSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          if (movie.fullPosterUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.fullPosterUrl!,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 180,
                    color: SaintColors.surface,
                    child: Icon(
                      Icons.broken_image,
                      color: SaintColors.foreground.withValues(alpha: 0.3),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(width: 16),

          // Título y título original
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: SaintColors.primary,
                  ),
                ),
                if (movie.originalTitle != movie.title)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      movie.originalTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: SaintColors.foreground.withValues(alpha: 0.6),
                      ),
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
