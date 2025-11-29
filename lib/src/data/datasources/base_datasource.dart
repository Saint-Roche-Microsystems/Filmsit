import '../../data/models/movie_model.dart';

abstract class BaseDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getUpcomingMovies();
}