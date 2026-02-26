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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// IMAGEM
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.producer.imageUrl,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            /// CONTEÚDO PRINCIPAL
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// CATEGORIA
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF386641),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.producer.categoria.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// NOME
                  Text(
                    widget.producer.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// LOCALIZAÇÃO
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 13, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.producer.region,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// AVALIAÇÃO
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 3),
                            Text(
                              widget.producer.avaliacao.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          "(${widget.producer.totalAvaliacoes})",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// FAVORITO
            IconButton(
              constraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              padding: EdgeInsets.zero,
              onPressed: () => setState(() => _isFavorite = !_isFavorite),
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color(0xFF6A994E),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}