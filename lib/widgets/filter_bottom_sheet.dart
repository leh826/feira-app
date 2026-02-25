import 'package:flutter/material.dart';
import '../models/filter_model.dart';

class FilterDialogWidget extends StatefulWidget {
  final FilterModel filters;
  final Function(FilterModel) onApply;

  const FilterDialogWidget({
    super.key,
    required this.filters,
    required this.onApply,
  });

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  late String region;
  String? category;
  double? minRating;
  SortOption sortOption = SortOption.none;

  final List<String> regions = [
    "Belém",
    "Ananindeua",
    "Castanhal",
    "All",
  ];

  final List<String> categories = [
    "Frutas",
    "Verduras",
    "Legumes",
    "Orgânicos",
    "All",
  ];

  @override
  void initState() {
    super.initState();
    region = widget.filters.region;
    category = widget.filters.category;
    minRating = widget.filters.minRating;
    sortOption = widget.filters.sortOption;
  }

  Widget _buildStars(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Filtros",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: region,
              decoration: const InputDecoration(
                labelText: "Região",
                border: OutlineInputBorder(),
              ),
              items: regions
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (value) => setState(() => region = value!),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => category = value),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Avaliação mínima",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [5, 4, 3, 2, 1].map((star) {
                return ChoiceChip(
                  label: _buildStars(star.toDouble()),
                  selected: minRating == star,
                  onSelected: (_) => setState(() => minRating = star.toDouble()),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<SortOption>(
              value: sortOption,
              decoration: const InputDecoration(
                labelText: "Ordenar por",
                border: OutlineInputBorder(),
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
                  child: Text("Maior avaliação"),
                ),
                DropdownMenuItem(
                  value: SortOption.ratingLow,
                  child: Text("Menor avaliação"),
                ),
              ],
              onChanged: (value) => setState(() => sortOption = value!),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(
                    FilterModel(
                      region: region,
                      category: category == "All" ? null : category,
                      minRating: minRating,
                      sortOption: sortOption,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Aplicar Filtros"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}