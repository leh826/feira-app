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

  List<String> regions = [
    "Belém",
    "Ananindeua",
    "Castanhal",
    "Todos",
  ];

  List<String> categories = [
    "Frutas",
    "Verduras",
    "Hortaliças",
    "Legumes",
    "Orgânicos",
    "Temperos",
    "Veganos",
    "Todos",
  ];

  @override
  void initState() {
    super.initState();
    
    // Se a cidade do usuário não estiver na lista fixa, é adiciona dinamicamente.
    if (!regions.contains(widget.filters.region)) {
      regions.insert(0, widget.filters.region);
    }
    region = widget.filters.region;
    category = widget.filters.category;
    minRating = widget.filters.minRating;
    sortOption = widget.filters.sortOption;
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
            /// Título + botão fechar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filtros",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 18),
                    onPressed: () => Navigator.pop(context),
                    splashRadius: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: region,
              isExpanded: true, 
              decoration: const InputDecoration(
                labelText: "Cidade",
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
              isExpanded: true,
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

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Avaliação mínima",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8, 
              children: [5, 4, 3, 2, 1].map((star) {
                return ChoiceChip(
                  label: _buildStars(star.toDouble()),
                  selected: minRating == star,
                  onSelected: (_) => setState(() => minRating = star.toDouble()),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  widget.onApply(
                    FilterModel(
                      region: region,
                      category: category == "Todos" ? null : category,
                      minRating: minRating,
                      sortOption: sortOption,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Aplicar Filtros", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}