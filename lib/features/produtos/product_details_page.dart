import 'package:eguadafeira/data/producers_data.dart';
import 'package:eguadafeira/features/produtores/perfil_produtores.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final producer = MockDatabase.getProducerById(product.producerId);

    return Dialog(
      backgroundColor: Colors.transparent,
       insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE9E2D0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Título + fechar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E5E2C),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xFF2E5E2C),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                /// Imagem
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              
                const SizedBox(height: 15),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProdutorScreen(producer: producer),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.store,
                          color: Color(0xFF2E5E2C),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            producer.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E5E2C),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                /// Conservação
                const Text(
                  "Forma de Conservação",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5E2C),
                  ),
                ),
                const SizedBox(height: 5),
                Text(product.conservation),

                const SizedBox(height: 15),

                /// Produção
                const Text(
                  "Forma de Produção",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5E2C),
                  ),
                ),
                const SizedBox(height: 5),
                Text(product.production),

                const SizedBox(height: 20),

                /// Avaliações
                const Text(
                  "Avaliações",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5E2C),
                  ),
                ),
                const SizedBox(height: 10),

                ...product.reviews.map(
                  (review) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        Text(review.comment),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}