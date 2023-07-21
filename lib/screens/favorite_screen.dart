import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key, required this.favorites});

  final Set<WordPair> favorites;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: favorites.map((e) => ListTile(title: Text(e.asPascalCase))).toList(),
    );
  }
}
