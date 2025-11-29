import 'package:flutter/foundation.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_trending_movies_uc.dart';
import '../../domain/usecases/get_upcoming_movies.dart';

class MovieViewModel extends ChangeNotifier {
  final GetTrendingMovies getTrendingMovies;
  final GetUpcomingMovies getUpcomingMovies;

  MovieViewModel({
    required this.getTrendingMovies,
    required this.getUpcomingMovies,
  });

  // States
  List<Movie> trendingMovies = [];
  List<Movie> upcomingMovies = [];
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

  // Fetch Upcoming movies
  Future<void> fetchUpcomingMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      upcomingMovies = await getUpcomingMovies();
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
    await fetchUpcomingMovies();
  }
}