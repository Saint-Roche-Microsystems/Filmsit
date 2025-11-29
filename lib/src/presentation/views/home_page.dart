import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/movie_viewmodel.dart';

import '../widgets/search_bar.dart';
import '../widgets/home_sections/trending.dart';
import '../widgets/home_sections/discover.dart';
import '../widgets/home_sections/upcoming.dart';

import '../../themes/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MovieViewModel>();
      viewModel.fetchTrendingMovies();
      viewModel.fetchUpcomingMovies();
      viewModel.fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SaintColors.background,
      body: Consumer<MovieViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.trendingMovies.isEmpty && viewModel.upcomingMovies.isEmpty && viewModel.popularMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!),
                  ElevatedButton(
                    onPressed: () => viewModel.refresh(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
              onRefresh: () => viewModel.refresh(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.6, -0.5),
                    radius: 1.0,
                    colors: [
                      SaintColors.primary.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Barra de búsqueda
                        MovieSearchBar(searchController: searchController),
                        const SizedBox(height: 32),

                        // 2. Sección TOP 3
                        TrendingSection(),
                        const SizedBox(height: 20),

                        // 3. Sección Upcoming
                        UpcomingSection(),
                        const SizedBox(height: 40),

                        // 4. Sección Discover
                        DiscoverSection(),
                      ],
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}