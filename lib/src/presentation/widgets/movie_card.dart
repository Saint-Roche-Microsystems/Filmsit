import 'package:flutter/material.dart';

import '../../core/config.dart';
import '../../themes/index.dart';
import '../../domain/entities/movie_entity.dart';
import 'ribbon_badge.dart';
import 'score_circle.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final double? width;
  final String? ribbonText;
  final Color? ribbonColor;
  final bool? displayScore;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width,
    this.ribbonText,
    this.ribbonColor,
    this.displayScore,
  });

  @override
  Widget build(BuildContext context) {
    final content = GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ocupar espacio disponible con Expanded
          Expanded(
            child: Stack( // Imagen de la película con el círculo de calificación
              children: [
                SizedBox.expand(
                  child: PosterImageLoader(posterPath: movie.posterPath),
                ),

                // Círculo con calificación
                if(displayScore == true || displayScore == null)
                  Positioned(
                    bottom: 0,
                    right: 8,
                    child: ScoreCircle(
                      score: movie.voteAverage,
                      size: 50,
                    ),
                  ),

                // Cinta en la esquina
                if (ribbonText != null)
                  Positioned(
                    top: 15,
                    right: -20,
                    child: RibbonBadge(
                      text: ribbonText!,
                      color: ribbonColor ?? SaintColors.error,
                    ),
                  ),
              ],

            ),
          ),

          const SizedBox(height: 8),

          // Título de la película
          Center(
            child: Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: SaintColors.foreground,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    // Adaptar el contenido si se especifica un ancho
    return width != null
        ? SizedBox(width: width, child: content)
        : content;
  }
}

class PosterImageLoader extends StatelessWidget {
  final String? posterPath;

  const PosterImageLoader({
    super.key,
    this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 2 / 3,
        // Verificar si hay una imagen para mostrar
        child: posterPath != null
            ? Image.network(
          '${Config.apiPosterUrl}$posterPath',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return NoMovieDisplay();
          },
        )
        // Si no hay imagen mostrar un ícono
            : NoMovieDisplay(),
      ),
    );
  }
}


class NoMovieDisplay extends StatelessWidget {
  const NoMovieDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.movie,
        size: 64,
        color: Colors.grey,
      ),
    );
  }
}

