import 'package:filmsit/src/data/repositories/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/config.dart';
import 'src/themes/index.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/viewmodels/movie_viewmodel.dart';

import 'src/data/repositories/movie_repository.dart';
import 'src/data/datasources/base_datasource.dart';
import 'src/data/datasources/movie_api_datasource.dart';

import 'src/domain/usecases/get_trending_movies_uc.dart';

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
          Provider<BaseDataSource>.value(value: datasource),
          Provider<BaseRepository>.value(value: repository),

          // UseCases
          Provider<GetTrendingMovies>(
            create: (_) => GetTrendingMovies(repository),
          ),

          // ViewModel
          ChangeNotifierProvider<MovieViewModel>(
            create: (context) => MovieViewModel(
              getTrendingMovies: context.read<GetTrendingMovies>(),
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