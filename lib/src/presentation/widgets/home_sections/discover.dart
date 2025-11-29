import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/index.dart';
import '../filter_dropdown.dart';
import '../pagination/pagination.dart';
import '../../viewmodels/movie_viewmodel.dart';
import 'discover_grid.dart';

class DiscoverSection extends StatefulWidget {
  const DiscoverSection({super.key});

  @override
  State<DiscoverSection> createState() => _DiscoverSectionState();
}

class _DiscoverSectionState extends State<DiscoverSection> {
  // Controles de paginación
  int currentPage = 1;
  final int maxPages = 5;

  // Filtros
  String selectedFilter = 'all';
  final List<DropdownMenuItem<String>> filterItems = const [
    DropdownMenuItem(value: 'all', child: Text('Todos')),
    DropdownMenuItem(value: 'popular', child: Text('Populares')),
    DropdownMenuItem(value: 'recent', child: Text('Recientes')),
    DropdownMenuItem(value: 'featured', child: Text('Destacados')),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover',
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

            // 4.1 Dropdown de filtros
            FilterDropdown<String>(
                value: selectedFilter,
                items: filterItems,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedFilter = newValue;
                    });
                  }
                }
            ),
            const SizedBox(height: 24),

            // 4.2 Matriz 5x2
            DiscoverGrid(movies: vm.popularMovies),
            const SizedBox(height: 28),

            // 4.3 Paginación
            Pagination(
              currentPage: currentPage,
              maxPages: maxPages,
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
            ),
          ],
        );
      }
    );


  }
}

