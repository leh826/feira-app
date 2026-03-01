import 'package:flutter/material.dart';
import 'package:eguadafeira/models/producer.dart';
import 'package:eguadafeira/models/product.dart';
import 'package:eguadafeira/data/producers_data.dart';
import 'package:eguadafeira/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProdutorScreen extends StatelessWidget {
  final Producer producer;

  const ProdutorScreen({super.key, required this.producer});

  List<Product> get produtosDoProdutor {
    return MockDatabase.products
        .where((product) => product.producerId == producer.id)
        .toList();
  }

    Future<void> abrirWhatsApp(BuildContext context) async {
    final Uri url = Uri.parse(
      "https://wa.me/5591985958964?text=Olá, tenho interesse nos produtos de ${producer.name}!",
    );

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Abrir WhatsApp"),
        content: const Text(
          "Você será redirecionado para o WhatsApp. Deseja continuar?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Continuar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void mostrarModalProduto(BuildContext context, Product produto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          produto.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                produto.imageUrl,
                width: 350,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            // Categoria
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Categoria: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  TextSpan(text: produto.category),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Conservação
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Conservação: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  TextSpan(text: produto.conservation),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Produção
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Produção: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  TextSpan(text: produto.production),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Fechar"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E3D3),

      appBar: AppBar(title: Text(producer.name)),

      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirWhatsApp(context),
        backgroundColor: AppColors.primaryGreen,
        child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM DO PRODUTOR
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                producer.imageUrl,
                width: 500,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // REGIÃO
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primaryGreen),
                const SizedBox(width: 8),
                Text(producer.region),
              ],
            ),

            const SizedBox(height: 10),

            // CATEGORIA
            Text(
              "Categoria: ${producer.categoria}",
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 10),

            // AVALIAÇÃO
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                const SizedBox(width: 5),
                Text(
                  "${producer.avaliacao} (${producer.totalAvaliacoes} avaliações)",
                ),
              ],
            ),

            const SizedBox(height: 20),

                Text(
                  "Sobre o produtor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  producer.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

            const Text(
              "Nossos produtos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),

            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: produtosDoProdutor.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),

              itemBuilder: (context, index) {
                final produto = produtosDoProdutor[index];

                return GestureDetector(
                  onTap: () => mostrarModalProduto(context, produto),

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(blurRadius: 4, color: Colors.black12),
                      ],
                    ),

                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(produto.imageUrl),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(produto.name),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
