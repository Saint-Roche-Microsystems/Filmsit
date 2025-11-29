import 'package:flutter/material.dart';

import '../../domain/entities/movie_entity.dart';
import '../widgets/movie_card.dart';

class MovieCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(Movie)? onMovieTap;
  final String? ribbonText;
  final Color? ribbonColor;
  final double cardWidth;
  final double cardHeight;

  const MovieCarousel({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.ribbonColor,
    this.ribbonText,
    this.cardWidth = 200,
    this.cardHeight = 250,
  });

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: 0,
    );

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.cardHeight + 40,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return _buildCarouselItem(index);
        },
      ),
    );
  }

  Widget _buildCarouselItem(int index) {
    // Calcula la diferencia entre la página actual y este índice
    double difference = (_currentPage - index).abs();

    // Calcula la opacidad (1.0 para la tarjeta activa, menor para las demás)
    double opacity = 1.0 - (difference * 0.5).clamp(0.0, 0.7);

    // Calcula la escala (1.0 para la tarjeta activa, menor para las demás)
    double scale = 1.0 - (difference * 0.2).clamp(0.0, 0.3);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: scale, end: scale),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: opacity,
            child: Center(
              child: MovieCard(
                movie: widget.movies[index],
                onTap: () {
                  if (widget.onMovieTap != null) {
                    widget.onMovieTap!(widget.movies[index]);
                  }

                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                width: widget.cardWidth,
                ribbonText: 'hot',
              ),
            ),
          ),
        );
      },
    );
  }
}


