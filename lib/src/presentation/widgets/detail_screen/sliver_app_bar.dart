import 'package:flutter/material.dart';

import '../../../domain/entities/movie_details_entity.dart';
import '../../../themes/index.dart';

class MovieSliverAppBar extends StatelessWidget {
  final MovieDetails movie;
  
  const MovieSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: SaintColors.background,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(
                color: SaintColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: SaintColors.foreground,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            if (movie.fullBackdropUrl != null)
              Image.network(
                movie.fullBackdropUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: SaintColors.surface,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: SaintColors.foreground.withValues(alpha: 0.3),
                    ),
                  );
                },
              )
            else
              Container(
                color: SaintColors.surface,
                child: Icon(
                  Icons.movie,
                  size: 64,
                  color: SaintColors.foreground.withValues(alpha: 0.3),
                ),
              ),

            // Gradiente oscuro
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    SaintColors.background.withValues(alpha: 0.7),
                    SaintColors.background,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
