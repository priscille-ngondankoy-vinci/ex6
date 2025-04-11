import '../models/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class ArticleService {
  late Database _database;

  Database get database => _database;

  Future<Article> createArticle(nom, prix, nbArticles) async {
    final id = await _database.insert('Article', {
      "nom": nom,
      "prix": prix,
      "nbArticles": nbArticles,
    });
    final article = Article(nom: nom, prix: prix, nbArticles: nbArticles);
    return article;
  }

  Future<List<Article>> getArticles() async {
    final maps = await _database.query('Article');
    return List.generate(maps.length, (i) {
      return Article(
        nom: maps[i]['nom'] as String,
        prix: maps[i]['prix'] as double,
        nbArticles: maps[i]['nbArticles'] as int,
      );
    });
  }
  Future<void> deleteArticle(nom) async {
    await _database.delete('Article', where: 'nom = ?', whereArgs: [nom]);
  }
  Future<void> initDatabase() async {
    if (kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      databaseFactory = databaseFactoryFfiWeb;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      version: 1,
    );

    final result = await _database.rawQuery(
      "SELECT count(*) AS count FROM sqlite_master WHERE type='table' AND name='Article'",
    );

    if (result[0]["count"] == 0) {
      await _database.execute(
        'CREATE TABLE Article(id INTEGER PRIMARY KEY, nom TEXT, prix DOUBLE PRECISION, nbArticles INTEGER)',
      );
      await _database.insert('Article', <String, Object?>{
        'nom': 'Article 1',
        'prix': 20,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 2',
        'prix': 10,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 3',
        'prix': 15,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 4',
        'prix': 18,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 5',
        'prix': 30,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 6',
        'prix': 35,
      });
      await _database.insert('Article', <String, Object?>{
        'name': 'Article 7',
        'prix': 13,
      });
    }
  }

  void then(Null Function(dynamic posts) param0) {}

}

