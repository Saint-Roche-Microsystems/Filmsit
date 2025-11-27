import 'package:flutter/material.dart';

import '../widgets/search_bar.dart';
import '../widgets/home_sections/top_3.dart';
import '../widgets/home_sections/discover.dart';
import '../widgets/home_sections/trending.dart';

import '../../themes/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SaintColors.background,
      body: Container(
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
                Top3Section(),
                const SizedBox(height: 40),

                // 3. Sección Trending
                TrendingSection(),
                const SizedBox(height: 40),

                // 4. Sección Discover
                DiscoverSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
