import 'package:flutter/material.dart';
import '../models/filter_model.dart';
import '../core/utils/app_colors.dart';

class FilterActionBar extends StatelessWidget {
  final FilterModel filters;
  final VoidCallback onOpenFilters;
  final VoidCallback onClear;
  final Function(SortOption) onSortChanged;

  const FilterActionBar({
    super.key,
    required this.filters,
    required this.onOpenFilters,
    required this.onClear,
    required this.onSortChanged,
  });

  String _sortLabel(SortOption option) {
    switch (option) {
      case SortOption.nameAsc:
        return "Nome (A-Z)";
      case SortOption.nameDesc:
        return "Nome (Z-A)";
      case SortOption.ratingHigh:
        return "Melhor avaliação";
      case SortOption.ratingLow:
        return "Menor avaliação";
      case SortOption.none:
      default:
        return "Ordenar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔎 Botão Filtros (com cor do app)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onOpenFilters,
              icon: const Icon(
                Icons.filter_list,
                color: AppColors.primaryGreen,
              ),
              label: const Text(
                "Filtros",
                style: TextStyle(color: AppColors.primaryGreen),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(
                  color: AppColors.primaryGreen,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 📊 Ordenação + Limpar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                DropdownButtonFormField<SortOption>(
                  value: filters.sortOption,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryGreen,
                  ),
                  decoration: InputDecoration(
                    labelText: "Ordenar",
                    labelStyle: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),

                    // Borda normal
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.lightGrey,
                      ),
                    ),

                    // Borda quando selecionado (FOCO)
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primaryGreen,
                        width: 2,
                      ),
                    ),

                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: SortOption.none,
                      child: Text("Padrão"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.nameAsc,
                      child: Text("Nome (A-Z)"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.nameDesc,
                      child: Text("Nome (Z-A)"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.ratingHigh,
                      child: Text("Melhor avaliação"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.ratingLow,
                      child: Text("Menor avaliação"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      onSortChanged(value);
                    }
                  },
                ),

                const SizedBox(height: 6),

                // 🧼 LIMPAR ALINHADO À DIREITA
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onClear,
                    child: const Text(
                      "Limpar",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}