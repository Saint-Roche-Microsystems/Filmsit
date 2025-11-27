import 'package:flutter/material.dart';

import '../../themes/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFilter = 'all';
  int currentPage = 1;
  final int maxPages = 5;
  final TextEditingController searchController = TextEditingController();

  Widget _buildGlassContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: SaintColors.surface.withValues(alpha: 0.7),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: Border.all(
          color: SaintColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.37),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

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
                _buildSearchBar(),
                const SizedBox(height: 32),

                // 2. Sección TOP 3
                _buildTop3Section(),
                const SizedBox(height: 40),

                // 3. Sección Trending
                _buildTrendingSection(),
                const SizedBox(height: 40),

                // 4. Sección Discover
                _buildDiscoverSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SaintColors.primary.withValues(alpha: 0.15),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTop3Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOP 3',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: SaintColors.primary,
            shadows: [
              Shadow(
                color: SaintColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SaintColors.primary, SaintColors.secondary],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: SaintColors.primary.withValues(alpha: 0.4),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: List.generate(
            3,
                (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < 2 ? 16 : 0,
                ),
                child: _buildTop3Item(index + 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTop3Item(int number) {
    return _buildGlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Item $number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SaintColors.primary,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [SaintColors.primary, SaintColors.secondary],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SaintColors.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: SaintColors.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: SaintColors.primary,
            shadows: [
              Shadow(
                color: SaintColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < 4 ? 16 : 0,
                ),
                child: _buildGlassContainer(
                  width: 220,
                  child: Center(
                    child: Text(
                      'Trending ${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SaintColors.secondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: SaintColors.primary,
            shadows: [
              Shadow(
                color: SaintColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 4.1 Dropdown de filtros
        _buildFilterDropdown(),
        const SizedBox(height: 24),

        // 4.2 Matriz 5x2
        _buildDiscoverGrid(),
        const SizedBox(height: 28),

        // 4.3 Paginación
        _buildPagination(),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return _buildGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedFilter,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: SaintColors.primary,
            size: 22,
          ),
          style: TextStyle(
            color: SaintColors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: SaintColors.surface,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedFilter = newValue;
              });
            }
          },
          items: const [
            DropdownMenuItem(value: 'all', child: Text('Todos')),
            DropdownMenuItem(value: 'popular', child: Text('Populares')),
            DropdownMenuItem(value: 'recent', child: Text('Recientes')),
            DropdownMenuItem(value: 'featured', child: Text('Destacados')),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildGlassContainer(
          child: Center(
            child: Text(
              'Item ${index + 1}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: SaintColors.secondary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPagination() {
    // Calcular qué páginas mostrar (máximo 3)
    List<int> visiblePages = _getVisiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botón anterior
        _buildPaginationButton(
          icon: Icons.chevron_left,
          isActive: currentPage > 1,
          onTap: () {
            if (currentPage > 1) {
              setState(() {
                currentPage--;
              });
            }
          },
        ),
        const SizedBox(width: 12),

        // Números de página visibles
        ...visiblePages.map((page) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildPageNumber(page),
          );
        }).toList(),

        // Botón siguiente
        _buildPaginationButton(
          icon: Icons.chevron_right,
          isActive: currentPage < maxPages,
          onTap: () {
            if (currentPage < maxPages) {
              setState(() {
                currentPage++;
              });
            }
          },
        ),
      ],
    );
  }

  List<int> _getVisiblePages() {
    // Si hay 3 o menos páginas, mostrar todas
    if (maxPages <= 3) {
      return List.generate(maxPages, (index) => index + 1);
    }

    // Si estamos en la primera página, mostrar [1, 2, 3]
    if (currentPage == 1) {
      return [1, 2, 3];
    }

    // Si estamos en la última página, mostrar las últimas 3
    if (currentPage == maxPages) {
      return [maxPages - 2, maxPages - 1, maxPages];
    }

    // En cualquier otro caso, mostrar la página actual en el centro
    return [currentPage - 1, currentPage, currentPage + 1];
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [SaintColors.secondary, SaintColors.secondary],
          )
              : null,
          color: isActive ? null : SaintColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? SaintColors.primary.withValues(alpha: 0.5)
                : SaintColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: SaintColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive
              ? SaintColors.background
              : SaintColors.foreground.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildPageNumber(int page) {
    final isActive = currentPage == page;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = page;
        });
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [SaintColors.secondary, SaintColors.secondary],
          )
              : null,
          color: isActive ? null : SaintColors.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? SaintColors.primary.withValues(alpha: 0.5)
                : SaintColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: SaintColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? SaintColors.background
                  : SaintColors.foreground,
            ),
          ),
        ),
      ),
    );
  }
}
