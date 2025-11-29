import '../../domain/entities/movie_entity.dart';

abstract class BaseRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getPopularMovies({int page = 1});
}