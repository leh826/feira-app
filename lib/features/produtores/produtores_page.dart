import 'package:eguadafeira/models/producer.dart';
import 'package:flutter/material.dart';

class ProducerCard extends StatefulWidget {
  final Producer producer;

  const ProducerCard({super.key, required this.producer});

  @override
  State<ProducerCard> createState() => _ProducerCardState();
}

class _ProducerCardState extends State<ProducerCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Bordas mais arredondadas como no print
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
// ... dentro do build do ProducerCard ...
child: Padding(
  padding: const EdgeInsets.all(10.0), // Reduzi de 12 para 10
  child: Row(
    children: [
      // IMAGEM UM POUCO MENOR PARA DAR ESPAÇO
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.producer.imageUrl,
          width: 90,  // Reduzi de 100 para 90
          height: 90, // Reduzi de 100 para 90
          fit: BoxFit.cover,
          // ... errorBuilder ...
        ),
      ),
      const SizedBox(width: 12), // Reduzi de 16 para 12

      // CONTEÚDO (Ocupa o que sobrar)
      Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Removi o MainAxisSize.min para permitir que ela ocupe a altura necessária
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        // 1. CATEGORIA (O Badge verde)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF386641),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.producer.categoria.toUpperCase(),
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 9, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 4),

        // 2. NOME DO PRODUTOR
        Text(
          widget.producer.name,
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),

        // 3. LOCALIZAÇÃO (O que tinha sumido)
        Row(
          children: [
            const Icon(Icons.location_on, size: 12, color: Colors.grey),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                widget.producer.region, // Usando o campo do seu modelo
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // 4. AVALIAÇÃO ESTILIZADA (O que tinha sumido)
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    widget.producer.avaliacao.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "(${widget.producer.totalAvaliacoes})",
              style: TextStyle(color: Colors.grey[500], fontSize: 11),
            ),
          ],
        ),
      ],
    ),
  ),
),

      // BOTÃO FAVORITO (Tamanho fixo)
      SizedBox(
        width: 40, // Limita a largura do botão para não empurrar o Row
        child: IconButton(
          padding: EdgeInsets.zero, // Remove o padding interno do botão
          onPressed: () => setState(() => _isFavorite = !_isFavorite),
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: const Color(0xFF6A994E),
            size: 24, // Reduzi levemente de 28 para 24
          ),
        ),
      ),
    ],
  ),
),
    );
  }
}