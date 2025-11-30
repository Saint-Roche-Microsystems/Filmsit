import '../../data/repositories/movie_repository.dart';
import '../entities/movie_entity.dart';

class SearchMovies {
  final MovieRepository repo;

  SearchMovies(this.repo);

  Future<List<Movie>> call({required String query}) async {
    return await repo.searchMovies(querry: query);
  }
}