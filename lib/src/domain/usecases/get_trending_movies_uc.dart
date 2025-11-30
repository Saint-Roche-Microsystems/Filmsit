import '../../data/repositories/movie_repository.dart';
import '../entities/movie_entity.dart';

class GetTrendingMovies {
  final MovieRepository repo;

  GetTrendingMovies(this.repo);

  Future<List<Movie>> call() async {
    return await repo.getTrendingMovies();
  }
}