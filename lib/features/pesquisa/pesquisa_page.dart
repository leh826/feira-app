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
import '../../widgets/custom_help.dart';

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
      filters = FilterModel(
        region: widget.userData['cidade'] ?? "Todos",
        category: null,
        minRating: null,
        sortOption: SortOption.none,
      );
      _applySearch();
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.filter_list_off, color: Colors.white),
            SizedBox(width: 12),
            Text("Filtros limpos com sucesso!"),
          ],
        ),
        backgroundColor: AppColors.primaryGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _openHelp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => CustomHelp(
        title: "Ajuda da Tela de Pesquisa",
        primaryColor: AppColors.primaryGreen,
        items: [
          HelpItem(
            question: "O que posso fazer nesta tela?",
            answer:
                "Aqui você pode pesquisar produtos pelo nome e aplicar filtros para encontrar exatamente o que procura.",
          ),
          HelpItem(
            question: "Como funciona a busca?",
            answer:
                "Digite o nome do produto na barra de pesquisa. Os resultados são atualizados automaticamente.",
          ),
          HelpItem(
            question: "Como usar os filtros?",
            answer:
                "Toque no botão de filtros para selecionar categoria, avaliação mínima ou ordenação.",
          ),
          HelpItem(
            question: "O que são filtros ativos?",
            answer:
                "Mostram quais filtros estão aplicados no momento e permitem removê-los individualmente.",
          ),
          HelpItem(
            question: "Como limpar todos os filtros?",
            answer:
                "Toque em 'Limpar' na barra de ações para resetar todos os filtros.",
          ),
          HelpItem(
            question: "Como ver detalhes do produto?",
            answer:
                "Toque em qualquer produto listado para abrir a tela de detalhes.",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          /// CARD DE AJUDA (IGUAL AO DA IMAGEM)
          GestureDetector(
            onTap: _openHelp,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              color: const Color(0xFFEDE6D6), // Bege semelhante ao da imagem
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryGreen,
                        width: 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.question_mark,
                      color: AppColors.primaryGreen,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Precisa de ajuda?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Veja como funciona a busca no Égua da Feira.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
          ),

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
                            builder: (_) =>
                                ProductDetailsPage(product: product),
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