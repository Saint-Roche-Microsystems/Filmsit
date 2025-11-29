import 'base_repository.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_api_datasource.dart';

class MovieRepository implements BaseRepository {
  final MovieDataSource ds;

  MovieRepository({required this.ds});

  // Get only the first 3 Trending Movies
  @override
  Future<List<Movie>> getTrendingMovies() async {
    try {
      final movieModels = await ds.getTrendingMovies();
      return movieModels.take(3).map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  // Get only the first 5 upcoming movies
  @override
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final movieModels = await ds.getUpcomingMovies();
      return movieModels.take(5).map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

}