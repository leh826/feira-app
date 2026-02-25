import 'package:flutter/material.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/product_card_widget.dart';
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
  FilterModel filters = const FilterModel(region: "Belém");
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
    showModalBottomSheet(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa'),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            onChanged: _onSearchChanged,
            onFilterTap: _openFilters,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Região: ${filters.region}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
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
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}