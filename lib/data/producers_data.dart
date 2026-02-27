import 'package:eguadafeira/models/review.dart';

import '../models/producer.dart';
import '../models/product.dart';
import '../models/filter_model.dart';

class MockDatabase {
  static final List<Producer> producers = [
    Producer(
      id: "p1",
      name: "João Hortifruti",
      region: "Belém",
      imageUrl: "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
      categoria: 'Hortifruti', 
      avaliacao: 4.5, 
      totalAvaliacoes: 120,
      description: "Produtor familiar especializado em hortaliças orgânicas, cultivadas sem agrotóxicos e com práticas sustentáveis.",
    ),
    Producer(
      id: "p2",
      name: "Fazenda Verde",
      region: "Ananindeua",
      imageUrl: "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
      categoria: 'Hortifruti', 
      avaliacao: 4.0, 
      totalAvaliacoes: 85,
      description: "Produtor familiar especializado em hortaliças orgânicas, cultivadas sem agrotóxicos e com práticas sustentáveis.",
    ),
    Producer(
      id: "p3",
      name: "Sítio Boa Terra",
      region: "Castanhal",
      imageUrl: "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
      categoria: 'Hortifruti', 
      avaliacao: 5.0, 
      totalAvaliacoes: 150,
      description: "Produtor familiar especializado em hortaliças orgânicas, cultivadas sem agrotóxicos e com práticas sustentáveis.",
    ),
  ];

  static final List<Product> products = [
    Product(
      id: "prod1",
      name: "Tomate Orgânico",
      price: 8.50,
      producerId: "p1",
      imageUrl: "https://images.unsplash.com/photo-1657786269673-ce9d14962651?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      category: "Hortaliças",
      conservation:
        "Conservar em local fresco e arejado. Na geladeira dura até 7 dias.",
      production:
          "Cultivado sem agrotóxicos, com adubação natural e irrigação controlada.",
      reviews: mockReviews1,
        rating: 4.5,
    ),
    Product(
      id: "prod2",
      name: "Alface Crespa",
      price: 3.00,
      producerId: "p2",
      imageUrl: "https://images.unsplash.com/photo-1692606280428-7df25e4daefb?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      category: "Hortaliças",
      rating: 4.0,
       conservation:
        "Manter refrigerado e consumir em até 5 dias.",
      production:
          "Produzido em sistema hidropônico com controle de nutrientes.",
      reviews: mockReviews2,
    ),
    Product(
      id: "prod3",
      name: "Cenoura",
      price: 5.20,
      producerId: "p3",
      imageUrl: "https://images.unsplash.com/photo-1769258896450-afaf01876052?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      category: "Legumes",
      rating: 4.0,
      conservation:
        "Guardar na geladeira dentro de saco perfurado por até 10 dias.",
      production:
          "Cultivo tradicional com rotação de culturas para manter o solo saudável.",
      reviews: [
        Review(
          userName: "Fernanda Lima",
          rating: 4,
          comment: "Bem crocante e doce.",
        ),
        ],
    ),
    Product(
      id: "prod4",
      name: "Batata Doce",
      price: 6.00,
      producerId: "p2",
      imageUrl: "https://images.unsplash.com/photo-1570723735746-c9bd51bd7c40?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      category: "Não cadastrada",
      rating: 5.0,
      conservation:
        "Armazenar em local seco e ventilado por até 15 dias.",
      production:
          "Plantio orgânico com controle biológico de pragas.",
      reviews: [],
    ),
    Product(
      id: "prod5",
      name: "Morango",
      price: 12.00,
      producerId: "p3",
      imageUrl: "https://images.unsplash.com/photo-1591271300850-22d6784e0a7f?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      category: "Frutas",
      rating: 5.0,
      conservation:
        "Manter refrigerado e consumir em até 3 dias.",
      production:
          "Cultivado em estufa com controle de temperatura e irrigação por gotejamento.",
      reviews: [
        Review(
          userName: "Juliana Rocha",
          rating: 5,
          comment: "Extremamente doce e fresco!",
        ),
        Review(
          userName: "Rafael Costa",
          rating: 5,
          comment: "Os melhores morangos que já comprei.",
        ),
      ],
    ),
  ];

  static List<Review> mockReviews1 = [
    Review(
      userName: "Maria Silva",
      rating: 5,
      comment: "Muito fresco e saboroso!",
    ),
    Review(
      userName: "Carlos Souza",
      rating: 4,
      comment: "Chegou bem embalado e rápido.",
    ),
  ];

  static List<Review> mockReviews2 = [
    Review(
      userName: "Ana Paula",
      rating: 5,
      comment: "Produto excelente, recomendo!",
    ),
  ];

  static List<Product> getProductsByRegion(String region) {
    if (region == "Todos") return List.from(products);

    final producerIds = producers
        .where((producer) => producer.region == region)
        .map((producer) => producer.id)
        .toSet();

    return products
        .where((product) => producerIds.contains(product.producerId))
        .toList();
  }

  static List<Product> searchProducts(String query, String region) {
    final normalizedQuery = query.trim().toLowerCase();

    List<Product> baseList = getProductsByRegion(region);

    // Se não digitou nada, retorna tudo da região
    if (normalizedQuery.isEmpty) {
      return baseList;
    }

    return baseList.where((product) {
      final producer = _getProducerSafe(product.producerId);

      final matchesProduct =
          product.name.toLowerCase().contains(normalizedQuery);

      final matchesProducer = producer.name
          .toLowerCase()
          .contains(normalizedQuery);

      return matchesProduct || matchesProducer;
    }).toList();
  }

  static List<Product> advancedSearch({
    required String query,
    required FilterModel filters,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    List<Product> result = List.from(products);

    //região
    if (filters.region != "Todos") {
      final producerIds = producers
          .where((p) => p.region == filters.region)
          .map((p) => p.id)
          .toSet();

      result = result
          .where((product) => producerIds.contains(product.producerId))
          .toList();
    }

    //texto (produto OU produtor)
    if (normalizedQuery.isNotEmpty) {
      result = result.where((product) {
        final producer = _getProducerSafe(product.producerId);

        final matchesProduct =
            product.name.toLowerCase().contains(normalizedQuery);

        final matchesProducer =
            producer.name.toLowerCase().contains(normalizedQuery);

        return matchesProduct || matchesProducer;
      }).toList();
    }

    //categoria
    if (filters.category != null &&
        filters.category!.isNotEmpty &&
        filters.category != "Todos") {
      result = result
          .where((product) => product.category == filters.category)
          .toList();
    }

    //avaliação
    if (filters.minRating != null) {
      result = result
          .where((product) => product.rating >= filters.minRating!)
          .toList();
    }

    //ordenação
    switch (filters.sortOption) {
      case SortOption.nameAsc:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;

      case SortOption.nameDesc:
        result.sort((a, b) => b.name.compareTo(a.name));
        break;

      case SortOption.ratingHigh:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;

      case SortOption.ratingLow:
        result.sort((a, b) => a.rating.compareTo(b.rating));
        break;

      case SortOption.none:
        break;
    }

    return result;
  }

  static Producer _getProducerSafe(String id) {
    return producers.firstWhere(
      (producer) => producer.id == id,
      orElse: () => Producer(
        id: "unknown",
        name: "Produtor desconhecido",
        region: "Desconhecida",
        imageUrl: "",
        categoria: 'sem categoria',
        avaliacao: 0.0, 
        totalAvaliacoes: 0,
        description: "Este produtor não possui informações disponíveis no momento.",
      ),
    );
  }

  static Producer getProducerById(String id) {
    return _getProducerSafe(id);
  }

  static List<String> getCategories() {
    final categories = products
        .map((product) => product.category)
        .toSet()
        .toList();

    categories.sort();
    categories.insert(0, "Todos");

    return categories;
  }
}