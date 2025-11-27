import 'package:flutter/material.dart';
import 'arrow_controls.dart';
import 'number_controls.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int maxPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.maxPages,
    required this.onPageChanged,
  });

  List<int> _getVisiblePages() {
    if (maxPages <= 3) {
      return List.generate(maxPages, (index) => index + 1);
    }

    if (currentPage == 1) {
      return [1, 2, 3];
    }

    if (currentPage == maxPages) {
      return [maxPages - 2, maxPages - 1, maxPages];
    }

    return [currentPage - 1, currentPage, currentPage + 1];
  }

  @override
  Widget build(BuildContext context) {
    List<int> visiblePages = _getVisiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Botón anterior
        ArrowControls(
            icon: Icons.chevron_left,
            isActive: currentPage > 1,
            onTap: () {
              if(currentPage > 1) {
                onPageChanged(currentPage - 1);
              }
            }
        ),
        const SizedBox(width: 12),

        // Números de página visibles
        ...visiblePages.map((page) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: NumberControls(
              page: page,
              isActive: currentPage == page,
              onTap: () => onPageChanged(page),
            ),
          );
        }),

        // Botón siguiente
        ArrowControls(
            icon: Icons.chevron_right,
            isActive: currentPage < maxPages,
            onTap: () {
              if(currentPage < maxPages) {
                onPageChanged(currentPage + 1);
              }
            }
        ),
      ],
    );
  }
}
