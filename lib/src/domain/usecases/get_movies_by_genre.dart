import '../../data/repositories/movie_repository.dart';
import '../entities/movie_entity.dart';

class GetMoviesByGenre {
  final MovieRepository repo;

  GetMoviesByGenre(this.repo);

  Future<List<Movie>> call(int genre, {int page = 1}) async {
    return await repo.getMoviesByGenre(genre, page: page);
  }
}