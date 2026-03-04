import 'package:eguadafeira/features/produtos/product_details_page.dart';
import 'package:eguadafeira/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:eguadafeira/models/producer.dart';
import 'package:eguadafeira/models/product.dart';
import 'package:eguadafeira/data/producers_data.dart';
import 'package:eguadafeira/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/custom_help.dart';

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
      builder: (_) => ProductDetailsPage(
        product: produto,
        showVendorButton: false, // Isso remove o botão "Ir ao vendedor"
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E3D3),

      appBar: AppBar(
        title: Text(producer.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (_) => CustomHelp(
                  title: "Ajuda da Tela",
                  primaryColor: AppColors.primaryGreen,
                  items: [
                    HelpItem(
                      question: "O que é esta tela?",
                      answer:
                          "Aqui você visualiza o perfil completo do produtor, incluindo informações, avaliações e produtos disponíveis.",
                    ),
                    HelpItem(
                      question: "Como entrar em contato?",
                      answer:
                          "Toque no botão verde do WhatsApp no canto inferior direito para falar diretamente com o produtor.",
                    ),
                    HelpItem(
                      question: "O que significa a avaliação?",
                      answer:
                          "Mostra a média das notas dadas por clientes que já compraram com este produtor.",
                    ),
                    HelpItem(
                      question: "Como ver os detalhes de um produto?",
                      answer:
                          "Toque em qualquer produto da grade para visualizar suas informações completas.",
                    ),
                    HelpItem(
                      question: "O que é a seção 'Sobre o produtor'?",
                      answer:
                          "Apresenta uma descrição com mais detalhes sobre o produtor e sua forma de trabalho.",
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

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
              crossAxisSpacing: 1, 
              mainAxisSpacing: 1,  
              childAspectRatio: 0.95,
            ),
              itemBuilder: (context, index) {
                final produto = produtosDoProdutor[index];

                return ProductCardWidget(
                  product: produto,
                  producer: producer,
                  onTap: () => mostrarModalProduto(context, produto),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
