import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../domain/entities/movie_details_entity.dart';
import '../../domain/usecases/get_movie_details.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final GetMovieDetails getMovieDetails;

  MovieDetailsViewModel({required this.getMovieDetails});

  // States
  MovieDetails? movieDetails;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchMovieDetails(int id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movieDetails = await getMovieDetails(id: id);
    } catch (e) {
      errorMessage = 'Error al cargar los detalles de la película: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearDetails() {
    movieDetails = null;
    errorMessage = null;
    notifyListeners();
  }
}