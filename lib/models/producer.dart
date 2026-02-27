class Producer { 
  final String id; 
  final String name; 
  final String region; 
  final String imageUrl; 
  final String categoria; 
  final double avaliacao; 
  final int totalAvaliacoes;
   final String description; 
  
Producer({ 
  required this.id, 
  required this.name, 
  required this.region, 
  required this.imageUrl, 
  required this.categoria, 
  required this.avaliacao, 
  required this.totalAvaliacoes,
  required this.description, 
  }); 
}