import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/genre_entity.dart';

abstract class BaseMovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getMoviesByGenre(int genre, {int page = 1});
}

abstract class BaseGenreRepository {
  Future<List<Genre>> getGenres();
}