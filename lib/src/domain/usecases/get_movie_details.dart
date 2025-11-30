import '../../data/repositories/movie_repository.dart';
import '../entities/movie_details_entity.dart';

class GetMovieDetails {
  final MovieRepository repo;

  GetMovieDetails(this.repo);

  Future<MovieDetails> call({required int id}) async {
    return await repo.getMovieDetails(id: id);
  }
}