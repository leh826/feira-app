import 'package:eguadafeira/features/produtos/product_details_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/product_card_widget.dart';
import '../../widgets/filter_action_bar.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../data/producers_data.dart';
import '../../models/product.dart';
import '../../models/producer.dart';
import '../../models/filter_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  FilterModel filters = const FilterModel(region: "Belém"); //mudar para a do usuário logado depois
  List<Product> results = [];

  @override
  void initState() {
    super.initState();
    _applySearch();
  }

  void _applySearch() {
    results = MockDatabase.advancedSearch(
      query: searchText,
      filters: filters,
    );
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
      filters = const FilterModel(
        region: "Todos",
        category: null,
        minRating: null,
        sortOption: SortOption.none,
      );
      _applySearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pesquisa'),
      // ),
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

          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum produto encontrado",
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