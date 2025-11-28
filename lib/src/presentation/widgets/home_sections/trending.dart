import 'package:filmsit/src/presentation/viewmodels/movie_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../themes/index.dart';
import '../glass_container.dart';

class TrendingSection extends StatelessWidget {
  final MovieViewModel vm;

  const TrendingSection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending',
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
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < 4 ? 16 : 0,
                ),
                child: GlassContainer(
                  width: 220,
                  child: Center(
                    child: Text(
                      vm.trendingMovies[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SaintColors.secondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
