import 'package:filmsit/src/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

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
        );
      },
    );
  }
}
