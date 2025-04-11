import 'package:ex6/services/article_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/article.dart';

class ArticleListView with ChangeNotifier {
  late ArticleService articleService;
  List<Article> _articles = [];

  ArticleListView(this.articleService) {
    articleService.then((articles) {
      _articles = articles;
      notifyListeners();
    });
  }

  List<Article> get articles => _articles;

  Article getArticle(String nom) =>
      articles.firstWhere((article) => article.nom.toString() == nom);

  Future<void> addArticle(String nom, double prix, int nbArticles) async {
    final article = await articleService.createArticle(nom, prix,nbArticles);
    _articles.add(article);
    notifyListeners();
  }

  Future<void> deleteArticle(String nom) async {
    await articleService.deleteArticle(nom);
    _articles.removeWhere((article) => article.nom == nom);
    notifyListeners();
  }
}