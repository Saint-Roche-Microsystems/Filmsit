import 'package:filmsit/src/domain/usecases/get_popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/config.dart';
import 'src/themes/index.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/viewmodels/movie_viewmodel.dart';

import 'src/data/repositories/base_repository.dart';
import 'src/data/repositories/movie_repository.dart';
import 'src/data/datasources/base_datasource.dart';
import 'src/data/datasources/movie_api_datasource.dart';

import 'src/domain/usecases/get_trending_movies_uc.dart';
import 'src/domain/usecases/get_upcoming_movies.dart';

void main() async {
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final datasource = MovieDataSource(client: httpClient);
    final repository = MovieRepository(ds: datasource);

    return MultiProvider(
        providers: [
          // Simple Providers
          Provider<http.Client>.value(value: httpClient),
          Provider<BaseMovieDataSource>.value(value: datasource),
          Provider<BaseMovieRepository>.value(value: repository),

          // UseCases
          Provider<GetTrendingMovies>(
            create: (_) => GetTrendingMovies(repository),
          ),

          Provider<GetUpcomingMovies>(
            create: (_) => GetUpcomingMovies(repository),
          ),

          Provider<GetPopularMovies>(
            create: (_) => GetPopularMovies(repository),
          ),

          // ViewModel
          ChangeNotifierProvider<MovieViewModel>(
            create: (context) => MovieViewModel(
              getTrendingMovies: context.read<GetTrendingMovies>(),
              getUpcomingMovies: context.read<GetUpcomingMovies>(),
              getPopularMovies: context.read<GetPopularMovies>()
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