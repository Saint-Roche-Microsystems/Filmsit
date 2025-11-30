import 'package:flutter/material.dart';

import '../../../themes/index.dart';
import '../../../domain/entities/movie_entity.dart';

class SearchResultItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const SearchResultItem({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [

            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: SaintColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.movie_outlined,
                color: SaintColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Movie Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: SaintColors.foreground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${movie.releaseDate.year}',
                    style: TextStyle(
                      fontSize: 13,
                      color: SaintColors.foreground.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: SaintColors.foreground.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}