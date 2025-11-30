import 'package:flutter/material.dart';

import '../../domain/entities/movie_details_entity.dart';
import '../widgets/detail_screen/sliver_app_bar.dart';
import '../widgets/detail_screen/budget_section.dart';
import '../widgets/detail_screen/genres_section.dart';
import '../widgets/detail_screen/main_section.dart';
import '../widgets/detail_screen/metadata_section.dart';
import '../widgets/detail_screen/overview_section.dart';
import '../widgets/detail_screen/production_section.dart';

class MovieDetailsContent extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsContent({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // AppBar con imagen de fondo
        MovieSliverAppBar(movie: movie),

        // Contenido
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información principal
              DetailsMainSection(movie: movie),
              const SizedBox(height: 24),

              // Rating y fecha
              MetadataSection(movie: movie),
              const SizedBox(height: 24),

              // Géneros
              if (movie.genres != null && movie.genres!.isNotEmpty)
                GenresSection(movie: movie),
              const SizedBox(height: 24),

              // Sinopsis
              OverviewSection(movie: movie),
              const SizedBox(height: 24),

              // Presupuesto
              if (movie.budget != null && movie.budget! > 0)
                BudgetSection(movie: movie),
              const SizedBox(height: 24),

              // Compañías productoras
              if (movie.productionCompaniesNames != null &&
                  movie.productionCompaniesNames!.isNotEmpty)
                ProductionSection(movie: movie),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
