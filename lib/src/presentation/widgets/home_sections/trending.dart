import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../../routes/movie_details_arguments.dart';

import '../../widgets/movie_carousel.dart';
import '../../viewmodels/movie_viewmodel.dart';
import '../../../themes/index.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TENDENCIA',
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
            MovieCarousel(
              movies: vm.trendingMovies,
              cardWidth: 180,
              onMovieTap: (movie) {
                Navigator.pushNamed(context,
                  AppRoutes.movieDetail,
                  arguments: MovieDetailsArguments(movieId: movie.id),
                );
              },
            ),
          ],
        );
      }
    );
  }
}
