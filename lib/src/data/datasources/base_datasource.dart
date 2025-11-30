import '../../data/models/movie_model.dart';
import '../../data/models/genre_model.dart';

abstract class BaseMovieDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getMoviesByGenre(int genre, {int page = 1});
  Future<List<MovieModel>> searchMovies({required String querry});
}

abstract class BaseGenreDataSource {
  Future<List<GenreModel>> getGenres();
}