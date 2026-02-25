import 'package:eguadafeira/models/review.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String producerId;
  final String imageUrl;
  final String category;
  final double rating;

 final String conservation; // NOVO
  final String production;   // NOVO
  final List<Review> reviews; // NOVO

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.producerId,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.conservation,
    required this.production,
    required this.reviews,
  });
}