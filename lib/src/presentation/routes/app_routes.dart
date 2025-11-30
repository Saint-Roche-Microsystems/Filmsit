import 'package:flutter/material.dart';

import 'movie_details_arguments.dart';
import '../views/error_page.dart';
import '../views/movie_details_page.dart';
import '../views/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String movieDetail = '/movie-detail';

  // Static routes pages
  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
  };

  // Dynamic pages with parameters
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Specify dynamic routes with cases

      // CASE: movie-detail
      case movieDetail:
      // Extraer argumentos
        final args = settings.arguments as MovieDetailsArguments?;

        // Show error if no arguments
        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => const ErrorPage(
              message: 'Error: No ha podido cargar los detalles de la película',
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => MovieDetailsPage(movieId: args.movieId),
        );

      // CASE: Route not found
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorPage(
            message: 'Página no encontrada',
          ),
        );
    }
  }
}
