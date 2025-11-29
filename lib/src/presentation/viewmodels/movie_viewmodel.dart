import 'package:flutter/foundation.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_trending_movies_uc.dart';

class MovieViewModel extends ChangeNotifier {
  final GetTrendingMovies getTrendingMovies;

  MovieViewModel({
    required this.getTrendingMovies,
  });

  // States
  List<Movie> trendingMovies = [];
  bool isLoading = false;
  int currentPage = 1;
  String? errorMessage;

  // Methods to manipulate state

  // Fetch Trending movies
  Future<void> fetchTrendingMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      trendingMovies = await getTrendingMovies();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Refresh
  Future<void> refresh() async {
    await fetchTrendingMovies();
  }
}