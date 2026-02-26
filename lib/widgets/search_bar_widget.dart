import 'package:flutter/material.dart';
import '../core/utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.hintText = "Buscar produtos ou produtores",
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      color: AppColors.primaryGreen,
      child: Row(
        children: [
          // Campo de busca
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.lightBeige,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

        ],
      ),
    );
  }
}