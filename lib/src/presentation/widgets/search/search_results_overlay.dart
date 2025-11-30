import 'package:flutter/material.dart';

import '../../../themes/index.dart';
import '../../../domain/entities/movie_entity.dart';
import 'search_result_item.dart';

class SearchResultsOverlay extends StatelessWidget {
  final bool isSearching;
  final List<Movie> searchResults;
  final String searchQuery;
  final Function(Movie) onMovieSelected;
  final VoidCallback onClose;

  const SearchResultsOverlay({
    super.key,
    required this.isSearching,
    required this.searchResults,
    required this.searchQuery,
    required this.onMovieSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 300,
      ),
      decoration: BoxDecoration(
        color: SaintColors.surface.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: SaintColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Header
          HeaderOverlay(
            isSearching: isSearching,
            onClose: onClose,
            searchResults: searchResults,
          ),

          Divider(height: 1, color: SaintColors.primary.withValues(alpha: 0.2)),

          // Lista de resultados
          // CASO 1: está buscando de la API
          if (isSearching)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            )

          // CASO 2: no encontró ningún resultado
          else if (searchResults.isEmpty)
            NoResults(searchQuery: searchQuery,)

          // CASO 3: si encontró resultados
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: searchResults.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: SaintColors.primary.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return SearchResultItem(
                    movie: movie,
                    onTap: () => onMovieSelected(movie),  // Pasar la película presionada al callback
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class HeaderOverlay extends StatelessWidget {
  final bool isSearching;
  final List<Movie> searchResults;
  final VoidCallback onClose;

  const HeaderOverlay({
    super.key,
    required this.isSearching,
    required this.searchResults,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              // Diferente texto si está buscando o no
              isSearching
                  ? 'Buscando...'
                  : 'Resultados (${searchResults.length})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: SaintColors.primary,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 20, color: SaintColors.foreground),
            onPressed: onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class NoResults extends StatelessWidget {
  final String searchQuery;

  const NoResults({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: SaintColors.foreground.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'No se encontraron resultados para "$searchQuery"',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: SaintColors.foreground.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

