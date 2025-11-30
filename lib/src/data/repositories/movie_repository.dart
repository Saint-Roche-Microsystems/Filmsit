import 'base_repository.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_api_datasource.dart';

class MovieRepository implements BaseMovieRepository {
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

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      // Retrieve results by groups of 10 per page from the API. (API returns 20 results per page)
      // ex: pages 1&2 use page 1 from the API
      int pageIndex = (page ~/ 2);
      if(page%2 != 0) {
        // Increment by 1 ONLY for odd pages
        pageIndex++;
      }

      final movieModels = await ds.getPopularMovies(page: pageIndex);

      // Odd numbers: 1-10
      if(page%2 == 0) {
        return movieModels.skip(10).map((model) => model.toEntity()).toList();
      }

      // Even numbers: 11-20
      return movieModels.take(10).map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genre, {int page = 1}) async {
    try {
      // Retrieve results by groups of 10 per page from the API. (API returns 20 results per page)
      // ex: pages 1&2 use page 1 from the API
      int pageIndex = (page ~/ 2);
      if(page%2 != 0) {
        // Increment by 1 ONLY for odd pages
        pageIndex++;
      }

      final movieModels = await ds.getMoviesByGenre(genre, page: pageIndex);

      // Odd numbers: 1-10
      if(page%2 == 0) {
        return movieModels.skip(10).map((model) => model.toEntity()).toList();
      }

      // Even numbers: 11-20
      return movieModels.take(10).map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<Movie>> searchMovies({required String querry}) async {
    try {
      final movieModels = await ds.searchMovies(querry: querry);
      return movieModels.map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

}