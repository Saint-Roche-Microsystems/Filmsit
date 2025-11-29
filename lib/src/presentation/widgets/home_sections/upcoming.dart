import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/movie_viewmodel.dart';
import '../../../themes/index.dart';
import '../movie_card.dart';

class UpcomingSection extends StatelessWidget {

  const UpcomingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming',
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
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < 4 ? 16 : 0,
                    ),
                    child: MovieCard(
                      movie: vm.upcomingMovies[index],
                      ribbonText: 'new',
                      ribbonColor: Colors.teal[700],
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
