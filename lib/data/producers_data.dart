import '../models/producer.dart';
import '../models/product.dart';
import '../models/filter_model.dart';

class MockDatabase {
  static final List<Producer> producers = [
    Producer(
      id: "p1",
      name: "João Hortifruti",
      region: "Belém",
      imageUrl: "https://via.placeholder.com/150",
    ),
    Producer(
      id: "p2",
      name: "Fazenda Verde",
      region: "Ananindeua",
      imageUrl: "https://via.placeholder.com/150",
    ),
    Producer(
      id: "p3",
      name: "Sítio Boa Terra",
      region: "Castanhal",
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];

  static final List<Product> products = [
    Product(
      id: "prod1",
      name: "Tomate Orgânico",
      price: 8.50,
      producerId: "p1",
      imageUrl: "https://via.placeholder.com/150",
      category: "Hortaliças",
      rating: 4.5,
    ),
    Product(
      id: "prod2",
      name: "Alface Crespa",
      price: 3.00,
      producerId: "p1",
      imageUrl: "https://via.placeholder.com/150",
      category: "Hortaliças",
      rating: 4.0,
    ),
    Product(
      id: "prod3",
      name: "Cenoura",
      price: 5.20,
      producerId: "p2",
      imageUrl: "https://via.placeholder.com/150",
      category: "Legumes",
      rating: 4.0,
    ),
    Product(
      id: "prod4",
      name: "Batata Doce",
      price: 6.00,
      producerId: "p2",
      imageUrl: "https://via.placeholder.com/150",
      category: "Não cadastrada",
      rating: 5.0,
    ),
    Product(
      id: "prod5",
      name: "Morango",
      price: 12.00,
      producerId: "p3",
      imageUrl: "https://via.placeholder.com/150",
      category: "Frutas",
      rating: 5.0,
    ),
  ];

  static List<Product> getProductsByRegion(String region) {
    if (region == "All") return List.from(products);

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
    if (filters.region != "All") {
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
        filters.category != "All") {
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
    categories.insert(0, "All");

    return categories;
  }
}