import 'package:flutter/material.dart';

import '../../themes/index.dart';
import 'glass_container.dart';

class FilterDropdown<T> extends StatelessWidget {
  final T Function() valueGetter;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  const FilterDropdown({
    super.key,
    required this.valueGetter,
    required this.items,
    required this.onChanged,
    this.hint,
    this.padding,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final value = valueGetter();

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            hint: hint != null
                ? Text(
              hint!,
              style: TextStyle(
                color: SaintColors.foreground.withValues(alpha: 0.6),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
                : null,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: SaintColors.primary,
              size: iconSize ?? 22,
            ),
            style: TextStyle(
              color: SaintColors.foreground,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: SaintColors.surface,
            onChanged: onChanged,
            items: items,
          ),
        ),
      ),
    );
  }
}


