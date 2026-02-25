import 'package:flutter/material.dart';

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
        horizontal: 16,
        vertical: 10,
      ),
      // color: Colors.white,
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
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Botão de filtro
        //   InkWell(
        //     onTap: onFilterTap,
        //     borderRadius: BorderRadius.circular(12),
        //     child: Container(
        //       padding: const EdgeInsets.all(12),
        //       decoration: BoxDecoration(
        //         color: Colors.grey.shade200,
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       child: const Icon(Icons.tune),
        //     ),
        //   ),
        ],
      ),
    );
  }
}