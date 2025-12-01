import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/index.dart';
import '../../../domain/entities/genre_entity.dart';
import '../../viewmodels/genre_viewmodel.dart';
import '../../viewmodels/movie_viewmodel.dart';
import '../pagination/pagination.dart';
import '../filter_dropdown.dart';
import 'discover_grid.dart';

class DiscoverSection extends StatefulWidget {
  const DiscoverSection({super.key});

  @override
  State<DiscoverSection> createState() => _DiscoverSectionState();
}

class _DiscoverSectionState extends State<DiscoverSection> {
  // Filtros
  List<DropdownMenuItem<int>> _getFilterItems(List<Genre> genres) {
    return [
      DropdownMenuItem<int>(value: 0, child: Text('Todos')),
      ...genres.map((genre) {
        return DropdownMenuItem(
            value: genre.id,
            child: Text(genre.name),
        );
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descubre',
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
        const SizedBox(height: 24),

        Consumer<GenreViewmodel>(
            builder: (context, genvm, child) {
              final filterItems = _getFilterItems(genvm.genresList);

              return FilterDropdown<int>(
                valueGetter: () => genvm.selectedGenre,
                items: filterItems,
                onChanged: (int? value) {
                  if (value != null) {
                    genvm.updateSelectedGenre(value);

                    if(value == 0){
                      context.read<MovieViewModel>().fetchPopularMovies();
                    } else {
                      context.read<MovieViewModel>().filterMoviesByGenre(value);
                    }
                  }
                },
              );
            }
        ),
        const SizedBox(height: 24),

        Consumer<MovieViewModel>(
            builder: (context, movvm, child) {
              return DiscoverGrid(movies: movvm.popularMovies);
            }
        ),

        const SizedBox(height: 28),

        // 4.3 Paginación
        Pagination(),

      ],
    );
  }
}

