import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/index.dart';
import '../viewmodels/movie_details_viewmodel.dart';
import 'movie_details_content.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDetailsViewModel>().fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SaintColors.background,
      body: Consumer<MovieDetailsViewModel>(
        builder: (context, viewModel, child) {

          // CASO 1: Cargando los datos de la API
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // CASO 2: Error al obtener los datos
          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: SaintColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.errorMessage!,
                    style: TextStyle(color: SaintColors.foreground),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.fetchMovieDetails(widget.movieId);
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          // Caso 3: No se encontraron detalles relacionados
          if (viewModel.movieDetails == null) {
            return const Center(
              child: Text('No se encontraron detalles'),
            );
          }

          // Caso 4: Mostrar pantalla de detalle
          return MovieDetailsContent(movie: viewModel.movieDetails!);
        },
      ),
    );
  }
}
