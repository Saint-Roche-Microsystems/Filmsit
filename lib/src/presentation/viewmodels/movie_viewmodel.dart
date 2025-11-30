import 'package:flutter/foundation.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_trending_movies_uc.dart';
import '../../domain/usecases/get_upcoming_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_movies_by_genre.dart';

class MovieViewModel extends ChangeNotifier {
  final GetTrendingMovies getTrendingMovies;
  final GetUpcomingMovies getUpcomingMovies;
  final GetPopularMovies getPopularMovies;
  final GetMoviesByGenre getMoviesByGenre ;

  MovieViewModel({
    required this.getTrendingMovies,
    required this.getUpcomingMovies,
    required this.getPopularMovies,
    required this.getMoviesByGenre,
  });

  // States
  List<Movie> trendingMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
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

  //Fetch Popular movies
  Future<void> fetchPopularMovies({int page = 1}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      popularMovies = await getPopularMovies(page: page);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch movies by the genre
  Future<void> filterMoviesByGenre(int genre, {int page = 1}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      popularMovies = await getMoviesByGenre(genre, page: page);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      updateCurrentPage(page);
      notifyListeners();
    }
  }

  // Pagination Methods for popular movies
  // Update currentPage number
  void updateCurrentPage(int page) {
    currentPage = page;
  }

  // Load next page
  Future<void> loadNextPage({int genre=0}) async {
    if(genre == 0) {
      await fetchPopularMovies(page: currentPage + 1);
    } else {
      await filterMoviesByGenre(genre, page:currentPage + 1);
    }
    updateCurrentPage(currentPage + 1);
  }

  // Load previous page
  Future<void> loadPreviousPage({int genre=0}) async {
    if (currentPage > 1) {
      if(genre == 0) {
        await fetchPopularMovies(page: currentPage - 1);
      } else {
        await filterMoviesByGenre(genre, page:currentPage - 1);
      }
    }
  }

  // Refresh
  Future<void> refresh() async {
    await fetchTrendingMovies();
    await fetchUpcomingMovies();
    await fetchPopularMovies(page: 1);
  }
}