import '../../data/repositories/genre_repository.dart';
import '../entities/genre_entity.dart';

class GetGenres {
  final GenreRepository repo;

  GetGenres(this.repo);

  Future<List<Genre>> call() async {
    return await repo.getGenres();
  }
}