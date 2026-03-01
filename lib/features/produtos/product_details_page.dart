import 'package:eguadafeira/data/producers_data.dart';
import 'package:eguadafeira/features/produtores/perfil_produtores.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final bool showVendorButton;

  const ProductDetailsPage({
    super.key, 
    required this.product, 
    this.showVendorButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final producer = MockDatabase.getProducerById(product.producerId);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E2D0), // Fundo bege do seu print
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Título + Botão Fechar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E5E2C),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2E5E2C),
                    radius: 18,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15),

              /// Imagem do Produto
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 15),

              /// BOTÃO "IR AO VENDEDOR"
              if (showVendorButton)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.store, color: Color(0xFF2E5E2C)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        producer.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E5E2C),
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProdutorScreen(producer: producer),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5E2C).withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Ir ao vendedor",
                        style: TextStyle(
                          color: Color(0xFF2E5E2C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (showVendorButton)const SizedBox(height: 20),

              /// Seção: Conservação
              const Text(
                "Forma de Conservação",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2E5E2C),
                ),
              ),
              const SizedBox(height: 5),
              Text(product.conservation, style: const TextStyle(fontSize: 14)),

              const SizedBox(height: 20),

              /// Seção: Produção
              const Text(
                "Forma de Produção",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2E5E2C),
                ),
              ),
              const SizedBox(height: 5),
              Text(product.production, style: const TextStyle(fontSize: 14)),

              const SizedBox(height: 20),

              /// Seção: Avaliações
              const Text(
                "Avaliações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2E5E2C),
                ),
              ),
              const SizedBox(height: 10),

              if (product.reviews.isEmpty)
                const Text(
                  "Ainda não há avaliações para este produto.",
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                )
              else
              ...product.reviews.map((review) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white),
                ),
                child: Column( // Mudamos para Column para o texto ficar embaixo
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CABEÇALHO: Foto, Nome e Nota
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF2E5E2C),
                          radius: 14,
                          child: Text(
                            review.userName[0].toUpperCase(), 
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            review.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E5E2C),
                            ),
                          ),
                        ),
                        // Estrelinha e Nota
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          review.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // TEXTO DO COMENTÁRIO
                    Text(
                      review.comment,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.3, // Melhora a leitura
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}