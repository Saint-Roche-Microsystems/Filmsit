import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config.dart';
import '../../core/errors/exceptions.dart';
import '../models/movie_model.dart';
import 'base_datasource.dart';

class MovieDataSource implements BaseDataSource {
  final http.Client client;

  MovieDataSource({required this.client});

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final res = await client.get(
      Uri.parse('${Config.apiBaseUrl}/trending/movie/week?language=es-MX'),
      headers: {
        'Authorization': 'Bearer ${Config.apiToken}',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List results = data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch trending movies');
    }
  }

}