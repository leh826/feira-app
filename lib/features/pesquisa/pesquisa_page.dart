import 'package:eguadafeira/core/utils/app_colors.dart';
import 'package:eguadafeira/features/produtos/product_details_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/product_card_widget.dart';
import '../../widgets/filter_action_bar.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/active_filters_widget.dart';
import '../../data/producers_data.dart';
import '../../models/product.dart';
import '../../models/producer.dart';
import '../../models/filter_model.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SearchScreen({super.key, required this.userData});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  
  late FilterModel filters;
  List<Product> results = [];

  @override
  void initState() {
    super.initState();
    
    // Inicializa os filtros com a cidade do usuário logado
    filters = FilterModel(
      region: widget.userData['cidade'] ?? "Todos",
    );
    
    _applySearch();
  }

  void _applySearch() {
    setState(() {
      results = MockDatabase.advancedSearch(
        query: searchText,
        filters: filters,
      );
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      _applySearch();
    });
  }

  void _openFilters() {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialogWidget(
          filters: filters,
          onApply: (newFilters) {
            setState(() {
              filters = newFilters;
              _applySearch();
            });
          },
        );
      },
    );
  }

  void _onSortChanged(SortOption option) {
    setState(() {
      filters = filters.copyWith(sortOption: option);
      _applySearch();
    });
  }

void _clearFilters() {
    setState(() {
      // 1. Reseta os filtros
      filters = FilterModel(
        region: widget.userData['cidade'] ?? "Todos",
        category: null,
        minRating: null,
        sortOption: SortOption.none,
      );
      _applySearch();
    });

    // 2. Remove qualquer SnackBar que ainda esteja na tela
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 3. Informa ao usuário que os filtros foram limpos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.filter_list_off, color: Colors.white),
            SizedBox(width: 12),
            Text("Filtros limpos com sucesso!"),
          ],
        ),
        backgroundColor: AppColors.primaryGreen, // O verde escuro da sua marca
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Faz a SnackBar flutuar (mais moderno)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16), // Espaçamento das bordas da tela
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            onChanged: _onSearchChanged,
            onFilterTap: _openFilters,
          ),

          FilterActionBar(
            filters: filters,
            onOpenFilters: _openFilters,
            onClear: _clearFilters,
            onSortChanged: _onSortChanged,
          ),

          ActiveFiltersWidget(
            filters: filters,
            onRemove: (newFilters) {
              setState(() {
                filters = newFilters;
                _applySearch();
              });
            },
          ),

          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum produto encontrado nesta região",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final product = results[index];
                      final Producer producer =
                          MockDatabase.getProducerById(product.producerId);

                      return ProductCardWidget(
                        product: product,
                        producer: producer,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black54,
                            builder: (_) => ProductDetailsPage(product: product),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}