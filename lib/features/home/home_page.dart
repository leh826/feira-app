import 'package:eguadafeira/features/produtores/produtores_page.dart';
import 'package:eguadafeira/models/producer.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  final List<Producer> producers;

  const HomePage({
    super.key,
    required this.producers,
  });

  @override
  Widget build(BuildContext context) {
    // Ordena pelos mais bem avaliados
    final topRated = [...producers]
      ..sort((a, b) => b.avaliacao.compareTo(a.avaliacao));

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
                  "Mais bem avaliados",
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
                height: 170, // Aumentado de 150 para 160 para evitar overflow na base
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.90), // Viewport ajustado
                  itemCount: topRated.length,
                  itemBuilder: (context, index) {
                    final producer = topRated[index];
                    return ProducerCard(producer: producer);
                  },
                ),
              ),

              const SizedBox(height: 24),
            
            ],
          ),
        ),
      ),
    );
  }
}