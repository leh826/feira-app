import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/producer.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final Producer producer;
  final VoidCallback? onTap;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.producer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),

        // leading: ClipRRect(
        //   borderRadius: BorderRadius.circular(8),
        //   child: Image.network(
        //     product.imageUrl,
        //     width: 60,
        //     height: 60,
        //     fit: BoxFit.cover,
        //   ),
        // ),

        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "${producer.name} • ${producer.region}",
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        trailing: Text(
          "R\$ ${product.price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}