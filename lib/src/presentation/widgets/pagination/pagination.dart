import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/genre_viewmodel.dart';
import '../../viewmodels/movie_viewmodel.dart';
import 'arrow_controls.dart';
import 'number_controls.dart';

class Pagination extends StatelessWidget {
  final int maxPages;

  const Pagination({
    super.key,
    this.maxPages = 5,  // hardcoded for now
  });

  // Genera una lista de número de 3 dependiendo de la página actual
  List<int> _getVisiblePages(int currentPage) {
    // Caso 1: si hay 3 o menos páginas en total
    if (maxPages <= 3) {
      return List.generate(maxPages, (index) => index + 1);
    }

    // Caso 2: si es la primera página
    if (currentPage == 1) {
    return [1, 2, 3];
    }

    // Caso 3: si es la última página
    if (currentPage == maxPages) {
    return [maxPages - 2, maxPages - 1, maxPages];
    }

    // Caso 4: Mostrar la página actual en el centro
    return [currentPage - 1, currentPage, currentPage + 1];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MovieViewModel, GenreViewmodel>(
      builder: (context, movVM, genVM, child) {
        // Obtener números de páginas visibles en base al ViewModel
        List<int> visiblePages = _getVisiblePages(movVM.currentPage);

        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Botón anterior
            ArrowControls(
                icon: Icons.chevron_left,
                isActiveCallback: () => movVM.currentPage > 1,
                onTap: () => movVM.loadPreviousPage(genre: genVM.selectedGenre),
            ),

            const SizedBox(width: 12),

           // Números de página visibles
            ...visiblePages.map((page) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: NumberControls(
                  page: page,
                  isActiveCallback: () => movVM.currentPage == page,
                  onTap: () {
                    movVM.filterMoviesByGenre(genVM.selectedGenre, page: page);
                    movVM.updateCurrentPage(page);
                  },
                ),
              );
            }),

           // Botón siguiente
            ArrowControls(
                icon: Icons.chevron_right,
                isActiveCallback: () => movVM.currentPage < maxPages,
                onTap: () => movVM.loadNextPage(genre: genVM.selectedGenre),
            ),
          ],
        );
      }
    );
  }
}
