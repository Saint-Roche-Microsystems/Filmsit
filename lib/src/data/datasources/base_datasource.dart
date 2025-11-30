import '../../data/models/movie_model.dart';
import '../../data/models/genre_model.dart';
import '../../data/models/movie_details_model.dart';

abstract class BaseMovieDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getMoviesByGenre(int genre, {int page = 1});
  Future<List<MovieModel>> searchMovies({required String querry});
  Future<MovieDetailsModel> getMovieDetails({required int id});
}

abstract class BaseGenreDataSource {
  Future<List<GenreModel>> getGenres();
}