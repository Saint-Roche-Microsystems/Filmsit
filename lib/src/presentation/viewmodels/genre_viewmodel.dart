import 'package:flutter/foundation.dart';

import '../../domain/entities/genre_entity.dart';
import '../../domain/usecases/get_genres.dart';

class GenreViewmodel extends ChangeNotifier {
  final GetGenres getGenres;

  GenreViewmodel({
    required this.getGenres,
  });

  // States
  List<Genre> genresList = [];
  bool isLoading = false;
  int selectedGenre = 0;
  String? errorMessage;

  // Methods to manipulate state
  Future<void> fetchGenres() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      genresList = await getGenres();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Update selectedGenre number
  void updateSelectedGenre(int genre) {
    selectedGenre = genre;
  }

  // Refresh
  Future<void> refresh() async {
    await fetchGenres();
    updateSelectedGenre(0);
  }
}