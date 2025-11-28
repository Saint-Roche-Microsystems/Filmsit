import '../../domain/entities/movie_entity.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    super.posterPath,
    required super.voteAverage,
    required super.releaseDate
  });

  // Create a Factory From JSON ---> To Model
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: DateTime.parse(json['release_date'] as String),
    );
  }

  // From Model ---> To JSON, for sending data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'release_date': releaseDate.toIso8601String(),
    };
  }

  // From Model ---> To Entity
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
    );
  }

}