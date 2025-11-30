import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/index.dart';
import '../../viewmodels/movie_viewmodel.dart';
import 'search_results_overlay.dart';

class MovieSearchBar extends StatefulWidget {

  const MovieSearchBar({super.key});

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  final TextEditingController searchController = TextEditingController();

  // Overlay related
  bool _isOverlayVisible = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // Search listener when changing text
  void _onSearchChanged() {
    // Do the API call
    final query = searchController.text;
    context.read<MovieViewModel>().searchMoviesWithDebounce(query);

    // Show overlay
    if (query.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _removeOverlay();
    searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  // Build and show overlay based on search results
  void _showOverlay() {
    if (_isOverlayVisible) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isOverlayVisible = true;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOverlayVisible = false;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 8.0),
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            child: Consumer<MovieViewModel>(
              builder: (context, movieVM, child) {
                return SearchResultsOverlay(
                  isSearching: movieVM.isSearching,
                  searchResults: movieVM.searchResults,
                  searchQuery: movieVM.searchQuery,
                  onMovieSelected: (movie) {
                    // Manejar selección de película
                    searchController.clear();
                    context.read<MovieViewModel>().clearSearch();
                    _removeOverlay();

                    // TODO: Navegar a detalles de la película
                    // Navigator.push(context, ...);
                  },
                  onClose: () {
                    _removeOverlay();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SearchInput(
        searchController: searchController,
        onPressed: () {
          searchController.clear();
          context.read<MovieViewModel>().clearSearch();
          _removeOverlay();
        },
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onPressed;

  const SearchInput({super.key, required this.searchController, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SaintColors.primary.withValues(alpha: 0.15),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar películas...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 22,
          ),
          // Show an "x" when there is text (a search)
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey[600]),
            onPressed: onPressed,
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
