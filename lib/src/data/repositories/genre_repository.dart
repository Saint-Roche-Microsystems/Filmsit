import 'base_repository.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/genre_entity.dart';
import '../datasources/genre_api_datasource.dart';

class GenreRepository implements BaseGenreRepository {
  final GenreDataSource ds;

  GenreRepository({required this.ds});

  @override
  Future<List<Genre>> getGenres() async {
    try {
      final genreModels = await ds.getGenres();
      return genreModels.map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

}