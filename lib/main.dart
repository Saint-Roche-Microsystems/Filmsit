import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/config.dart';
import 'src/themes/index.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/viewmodels/movie_viewmodel.dart';
import 'src/presentation/viewmodels/genre_viewmodel.dart';

import 'src/data/datasources/base_datasource.dart';
import 'src/data/datasources/movie_api_datasource.dart';
import 'src/data/datasources/genre_api_datasource.dart';

import 'src/data/repositories/base_repository.dart';
import 'src/data/repositories/movie_repository.dart';
import 'src/data/repositories/genre_repository.dart';

import 'src/domain/usecases/get_trending_movies_uc.dart';
import 'src/domain/usecases/get_upcoming_movies.dart';
import 'src/domain/usecases/get_popular_movies.dart';
import 'src/domain/usecases/get_movies_by_genre.dart';
import 'src/domain/usecases/search_movies.dart';
import 'src/domain/usecases/get_genres.dart';

void main() async {
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final movieDs = MovieDataSource(client: httpClient);
    final movieRep = MovieRepository(ds: movieDs);
    final genreDs = GenreDataSource(client: httpClient);
    final genreRep = GenreRepository(ds: genreDs);

    return MultiProvider(
        providers: [
          // Simple Providers
          Provider<http.Client>.value(value: httpClient),
          Provider<BaseMovieDataSource>.value(value: movieDs),
          Provider<BaseMovieRepository>.value(value: movieRep),
          Provider<BaseGenreDataSource>.value(value: genreDs),
          Provider<BaseGenreRepository>.value(value: genreRep),

          // UseCases
          Provider<GetTrendingMovies>(
            create: (_) => GetTrendingMovies(movieRep),
          ),

          Provider<GetUpcomingMovies>(
            create: (_) => GetUpcomingMovies(movieRep),
          ),

          Provider<GetPopularMovies>(
            create: (_) => GetPopularMovies(movieRep),
          ),

          Provider(
            create: (_) => GetMoviesByGenre(movieRep),
          ),

          Provider<SearchMovies>(
            create: (_) => SearchMovies(movieRep),
          ),

          Provider<GetGenres>(
            create: (_) => GetGenres(genreRep),
          ),

          // ViewModels
          ChangeNotifierProvider<MovieViewModel>(
            create: (context) => MovieViewModel(
              getTrendingMovies: context.read<GetTrendingMovies>(),
              getUpcomingMovies: context.read<GetUpcomingMovies>(),
              getPopularMovies: context.read<GetPopularMovies>(),
              getMoviesByGenre: context.read<GetMoviesByGenre>(),
              searchMovies: context.read<SearchMovies>(),
            ),
          ),

          ChangeNotifierProvider<GenreViewmodel>(
            create: (context) => GenreViewmodel(
              getGenres: context.read<GetGenres>(),
            ),
          ),
        ],
      child: MaterialApp(
        title: 'Filmsit',
        debugShowCheckedModeBanner: false,
        theme: getGeneralTheme(Brightness.dark),
        routes: AppRoutes.routes,
        initialRoute: '/',
      ),
    );
  }
}