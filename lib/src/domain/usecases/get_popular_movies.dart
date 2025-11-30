import '../../data/repositories/movie_repository.dart';
import '../entities/movie_entity.dart';

class GetPopularMovies {
  final MovieRepository repo;

  GetPopularMovies(this.repo);

  Future<List<Movie>> call({int page = 1}) async {
    return await repo.getPopularMovies(page: page);
  }
}