import 'package:filmsit/src/presentation/widgets/score_circle.dart';
import 'package:filmsit/src/themes/index.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final double? width;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 160,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la película con el círculo de calificación
            Stack(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: movie.posterPath != null
                        ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.movie,
                            size: 64,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                        : Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.movie,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                // Círculo con calificación en la esquina inferior derecha
                Positioned(
                  bottom: 0,
                  right: 8,
                  child: ScoreCircle(score: movie.voteAverage, size: 50,),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Título de la película
            Center(
              child: Text(
                movie.title,
                style: TextStyle(
                  //fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: SaintColors.foreground,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
