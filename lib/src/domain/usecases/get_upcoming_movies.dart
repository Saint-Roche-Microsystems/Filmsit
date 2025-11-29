import '../../data/repositories/movie_repository.dart';
import '../entities/movie_entity.dart';

class GetUpcomingMovies {
  final MovieRepository repo;

  GetUpcomingMovies( this.repo);

  Future<List<Movie>> call() async {
    return await repo.getUpcomingMovies();
  }
}