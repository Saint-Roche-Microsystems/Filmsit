import 'package:flutter/material.dart';
import '../../../themes/index.dart';
import '../glass_container.dart';

class DiscoverGrid extends StatelessWidget {
  const DiscoverGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
        return GlassContainer(
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
}
