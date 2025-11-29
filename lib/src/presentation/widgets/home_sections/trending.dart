import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/movie_viewmodel.dart';
import '../../../themes/index.dart';
import '../movie_card.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TRENDING',
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
            const SizedBox(height: 12),
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [SaintColors.primary, SaintColors.secondary],
                ),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: SaintColors.primary.withValues(alpha: 0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 260,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < 4 ? 16 : 0,
                      ),
                      child: MovieCard(
                        movie: vm.trendingMovies[index],
                        ribbonText: 'hot',
                      ),
                    );
                  },
              ),
            ),
          ],
        );
      }
    );
  }
}
