class Article {
  final String nom;
  final double prix;
  final int nbArticles;

  Article({required this.nom, required this.prix, this.nbArticles=0});

  @override
  String toString() {
    return 'Article{nom: $nom, prix: $prix, nbArticles: $nbArticles}';
  }
}