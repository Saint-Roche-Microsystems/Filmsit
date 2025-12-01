import '../../core/config.dart';
import 'genre_entity.dart';

class MovieDetails {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final DateTime releaseDate;
  final int? budget;
  final List<Genre>? genres;
  final List<String>? productionCompaniesNames;

  const MovieDetails({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.budget,
    this.genres,
    this.productionCompaniesNames,
  });

  // Helper Methods
  String? get fullPosterUrl => posterPath != null
      ? '${Config.apiPosterUrl}$posterPath'
      : null;

  String? get fullBackdropUrl => backdropPath != null
      ? '${Config.apiBackdropUrl}$backdropPath'
      : null;
}