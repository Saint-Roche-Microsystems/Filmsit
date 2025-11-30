import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config.dart';
import '../../core/errors/exceptions.dart';
import '../models/genre_model.dart';
import 'base_datasource.dart';

class GenreDataSource implements BaseGenreDataSource {
  final http.Client client;

  GenreDataSource({required this.client});

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await client.get(
      Uri.parse('${Config.apiBaseUrl}/genre/movie/list?language=es'),
      headers: {
        'Authorization': 'Bearer ${Config.apiToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['genres'] as List;
      return results.map((json) => GenreModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch genres');
    }
  }
}