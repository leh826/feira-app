import 'package:flutter/material.dart';
import '../models/filter_model.dart';
import '../core/utils/app_colors.dart';

class ActiveFiltersWidget extends StatelessWidget {
  final FilterModel filters;
  final Function(FilterModel) onRemove;

  const ActiveFiltersWidget({
    super.key,
    required this.filters,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> chips = [];

    if (filters.category != null) {
      chips.add(_chip(
        filters.category!,
        () => onRemove(filters.copyWith(category: null)),
      ));
    }

    if (filters.minRating != null) {
      chips.add(_chip(
        "${filters.minRating!.toInt()}★ ou mais",
        () => onRemove(filters.copyWith(minRating: null)),
      ));
    }

    if (filters.region != "Todos") {
      chips.add(_chip(
        filters.region,
        () => onRemove(filters.copyWith(region: "Todos")),
      ));
    }

    if (chips.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: chips,
      ),
    );
  }

  Widget _chip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onRemove,
      backgroundColor: Colors.grey.shade200,
      deleteIconColor: AppColors.primaryGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}