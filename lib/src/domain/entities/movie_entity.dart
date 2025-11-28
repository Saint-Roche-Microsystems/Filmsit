class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime releaseDate;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    required this.releaseDate
  });
}