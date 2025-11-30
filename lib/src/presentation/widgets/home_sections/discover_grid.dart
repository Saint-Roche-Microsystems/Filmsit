import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../routes/movie_details_arguments.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../widgets/movie_card.dart';

class DiscoverGrid extends StatelessWidget {
  final List<Movie> movies;

  const DiscoverGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
          displayScore: false,
          onTap: () {
            Navigator.pushNamed(context,
              AppRoutes.movieDetail,
              arguments: MovieDetailsArguments(movieId:movies[index].id),
            );
          },
        );
      },
    );
  }
}
