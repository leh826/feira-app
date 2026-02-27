import 'package:eguadafeira/features/produtores/produtores_page.dart';
import 'package:eguadafeira/features/produtos/product_details_page.dart';
import 'package:eguadafeira/models/producer.dart';
import 'package:eguadafeira/models/product.dart';
import 'package:eguadafeira/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  final List<Producer> producers;
  final List<Product> products;

  const HomePage({
    super.key,
    required this.producers,
     required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final topRated = [...producers]
      ..sort((a, b) => b.avaliacao.compareTo(a.avaliacao));

    final topProducts = [...products]
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Produtores bem avaliados",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 150, // Aumentado de 150 para 160 para evitar overflow na base
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.75), // Viewport ajustado
                  itemCount: topRated.length,
                  itemBuilder: (context, index) {
                    final producer = topRated[index];
                    return ProducerCard(producer: producer);
                  },
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Produtos bem avaliados",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 170,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.42),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = topProducts[index];

                    // Você precisa encontrar o produtor desse produto
                    final producer = producers.firstWhere(
                      (p) => p.id == product.producerId,
                    );

                    return ProductCardWidget(
                      product: product,
                      producer: producer,
                      onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (_) => ProductDetailsPage(product: product),
                      );
                    },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}