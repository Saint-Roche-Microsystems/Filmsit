import '../../domain/entities/genre_entity.dart';
import '../../domain/entities/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    super.budget,
    super.genres,
    super.productionCompaniesNames,
  });

  // Create a Factory From JSON ---> To Model
  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: DateTime.parse(json['release_date'] as String),
      budget: json['budget'] as int?,
      genres: json['genres'] != null
          ? (json['genres'] as List)
          .map((g) => Genre(
        id: g['id'] as int,
        name: g['name'] as String,
      ))
          .toList()
          : null,
      productionCompaniesNames: json['production_companies'] != null
          ? (json['production_companies'] as List)
          .map((pc) => pc['name'] as String).toList()
          : null,
    );
  }

  // From Model ---> To JSON, for sending data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'release_date': releaseDate.toIso8601String(),
      'budget': budget,
      'genres': genres,
      'production_companies': productionCompaniesNames,
    };
  }

  // From Model ---> To Entity
  MovieDetails toEntity() {
    return MovieDetails(
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      budget: budget,
      genres: genres,
      productionCompaniesNames: productionCompaniesNames,
    );
  }

}