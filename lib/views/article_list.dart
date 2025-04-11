import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


import '../article_list_view//article_list_view_model.dart';
import '../models/article.dart';



class _ArticleState extends State<Article> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prixController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final nom = _nomController.text;
      final content = _prixController.text;
      Provider.of<ArticleListView>(context, listen: false).addArticle();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator:
                    (value) =>
                (value == null || value.isEmpty)
                    ? 'Please enter a name'
                    : null,
              ),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
                validator:
                    (value) =>
                (value == null || value.isEmpty)
                    ? 'Please enter a content'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create Article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}