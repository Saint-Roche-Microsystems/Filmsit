import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config.dart';
import '../../core/errors/exceptions.dart';
import '../models/movie_model.dart';
import 'base_datasource.dart';

class MovieDataSource implements BaseMovieDataSource {
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

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final res = await client.get(
      Uri.parse('${Config.apiBaseUrl}/movie/upcoming?language=es-EC&page=1&region=MX'),
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
      throw ServerException(message: 'Failed to fetch upcoming movies');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await client.get(
      Uri.parse('${Config.apiBaseUrl}/movie/popular?language=es-MX&page=1&region=EC&page=$page'),
      headers: {
        'Authorization': 'Bearer ${Config.apiToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch popular movies');
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genre, {int page = 1}) async {
    final response = await client.get(
      Uri.parse('${Config.apiBaseUrl}/discover/movie?&with_genres=$genre&language=es-MX&page=$page'),
      headers: {
        'Authorization': 'Bearer ${Config.apiToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch movies by genre');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies({required String querry}) async {
    final response = await client.get(
      Uri.parse('${Config.apiBaseUrl}/search/movie?query=$querry'),
      headers: {
        'Authorization': 'Bearer ${Config.apiToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to search movies');
    }
  }
}